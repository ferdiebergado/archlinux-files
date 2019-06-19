#!/bin/bash

#userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
#sysresources=/etc/X11/xinit/.Xresources
#sysmodmap=/etc/X11/xinit/.Xmodmap

##xset +fp /usr/share/fonts/local
##xset +fp /usr/share/fonts/misc
##xset fp rehash
##xrdb $userresources

## merge in defaults and keymaps

#if [ -f $sysresources ]; then

#    xrdb -merge $sysresources

#fi

#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi

#if [ -f "$userresources" ]; then

#    xrdb -merge "$userresources"

#fi

#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Adjust display brightness depending on time of day
TIME=$(date +%k)
BRIGHTNESS=4
if [[ $TIME -le 24 && $TIME -ge 18 ]]; then
    BRIGHTNESS=1
    xflux -l 14.5 -g 120.9 &
fi
echo $BRIGHTNESS > /sys/class/backlight/acpi_video0/brightness &

# lxsession -na &
VGLRUN=""

start_xephyr() {

    xephyrdisplay=:78
    hostname=$(hostname)
    cleanlist=

    magiccookie=`/usr/bin/mcookie`

    if test x"$magiccookie" = x; then
        echo "Couldn't create cookie"
        exit 1
    fi
    defaultdisplay=78

    # create a file with auth information for the server. ':78' is a defaultdisplay.
    xephyrauthfile=`mktemp -p /tmp serverauth.XXXXXXXXXX`
    trap "rm -f '$xephyrauthfile'" HUP INT QUIT ILL TRAP KILL BUS TERM
xauth -q -f "$xephyrauthfile" << EOF
add :$defaultdisplay . $magiccookie
EOF

    for displayname in $xephyrdisplay $hostname/unix$xephyrdisplay; do
        authcookie=`xauth list "$displayname" \
        | sed -n "s/.*$hostname\/unix$xephyrdisplay[[:space:]*].*[[:space:]*]//p"` 2>/dev/null;
        if [ "z${authcookie}" = "z" ] ; then
        xauth -q << EOF
add $displayname . $magiccookie
EOF
        cleanlist="$displayname $cleanlist"
        else
            defaultdisplay=$(($defaultdisplay+1));
        xauth -q -f "$xephyrauthfile" << EOF
add :$defaultdisplay . $authcookie
EOF
        fi
    done

    Xephyr $xephyrdisplay -nolisten tcp -nolisten local -br -screen 1366x768 -dpi 96 -rgba rgb -once -tst -auth $xephyrauthfile &
    # inotifywait --timeout 9 /tmp/.X11-unix/
    sleep 1
    export DISPLAY=:78
    export VGL_LOGO=1
    VGLRUN="vglrun"
}

[[ -n $(uname -r | grep harden) ]] && start_xephyr

#xsetroot -solid black &

[[ $(pgrep -x devmon) -eq 0 ]] && devmon --exec-on-drive "notify-send --icon=/home/d0np0br3/Pictures/usb_drive128.png --urgency=low \"Volume %l has been mounted.\"" --exec-on-unmount "notify-send --icon=/home/d0np0br3/Pictures/black_drive_usb.png --urgency=low \"Volume %l has been unmounted\"" &

wmname LG3D &
lxpolkit &
# gnome-keyring-daemon --start --components=secrets &
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh) &
# export SSH_AUTH_SOCK
##clipit &
##clipmenud &
# [[ $(pgrep -x compton) -eq 0 ]] && compton --xrender-sync-fence &
#~/.fehbg &
# export SCRIPTDIR="/home/d0np0br3/.config/scripts"
# export WM="$1"
#systemd-run --user --on-boot=20m --on-unit-active=20m notify-send -u critical -t 5000 "20-Second Break" "Look at something 20 feet away."
urxvtd -q -o -f
compton --config ~/.config/compton/compton-xephyr.conf -b
[[ -z $(systemctl --user status clipmenud | grep -ow active) ]] && systemctl --user start clipmenud &
# sxhkd &
# (
#     while sleep 1; do katriabi bevelbar ; done |
#     while sleep 1; do bevelbar \
#     -h left -v top \
#     -H 10 -V 5 \
#     -b 3 -B 2 \
#     -m 2 -e 20 \
#     -f 'Terminus:pixelsize=10' \
#     -p '#212121' \
#     -o '#303030' -O '#202020' \
#     -s 0 -c '#212121' -c '#ededed' -c '#e1e1e1' -c '#262626' \
#     -s 1 -c '#212121' -c '#eeeeee' -c '#747474' -c '#e1e1e1' \
#     -s 2 -c '#a11212' -c '#ffffff' -c '#e61919' -c '#570A0A'; done
# ) &
# (
#     while sleep 1; do bevelbar-status; done |
#     while sleep 1; do bevelbar -h center -v bottom; done
# ) &
#  katriawm
$VGLRUN awesome --config ~/.config/awesome/rc.lua >> $XDG_RUNTIME_DIR/stdout 2>> $XDG_RUNTIME_DIR/stderr
# vglrun i3
#-V >> $XDG_RUNTIME_DIR/i3.log
# vglrun bspwm
# slstatus &
# vglrun dwm
if [ x"$cleanlist" != x ]; then
    xauth remove $cleanlist
fi
if [ x"$xephyrauthfile" != x ]; then
    rm -f "$xephyrauthfile"
fi
pkill -x Xorg
