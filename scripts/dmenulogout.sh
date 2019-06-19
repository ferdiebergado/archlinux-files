#!/bin/bash
DMENU_FONT="Ticking TimeBomb BB"
SB="#202020"
SF="#00FFFF"
ACTION=$(echo -e "lock\nlogout\nreboot\nshutdown\n" | dmenu -i -h 32 -p 'Exit:' -fn "$DMENU_FONT" -sb "$SB" -sf "$SF")
if [ -n $ACTION ]; then
    echo $ACTION
    case $ACTION in
        "lock")
            if [ $(pgrep -x dwm) -ne 0 ]; then
                slock
            else
                blurlock
            fi;;
        "logout")
            /home/d0np0br3/.config/scripts/logout.sh;;
       "reboot")
            tmux kill-server
            reboot;;
        "shutdown")
            tmux kill-server
            poweroff;;
    esac
fi
exit 0
