# export PANEL_FIFO="/tmp/panel-fifo"
# Switch locale
#printf '\33]701;%s\007' "$LC_CTYPE"

# if [ "$TERM" = "linux" ]; then
#     echo -en "\e]P0232323" #black
#     echo -en "\e]P82B2B2B" #darkgrey
#     echo -en "\e]P1D75F5F" #darkred
#     echo -en "\e]P9E33636" #red
#     echo -en "\e]P287AF5F" #darkgreen
#     echo -en "\e]PA98E34D" #green
#     echo -en "\e]P3D7AF87" #brown
#     echo -en "\e]PBFFD75F" #yellow
#     echo -en "\e]P48787AF" #darkblue
#     echo -en "\e]PC7373C9" #blue
#     echo -en "\e]P5BD53A5" #darkmagenta
#     echo -en "\e]PDD633B2" #magenta
#     echo -en "\e]P65FAFAF" #darkcyan
#     echo -en "\e]PE44C9C9" #cyan
#     echo -en "\e]P7E5E5E5" #lightgrey
#     echo -en "\e]PFFFFFFF" #white
#     clear #for background artifacting
# fi

# Solarized Dark
# if [ "$TERM" = "linux" ]; then
#     echo -en "\e]PB657b83" # S_base00
#     echo -en "\e]PA586e75" # S_base01
#     echo -en "\e]P0073642" # S_base02
#     echo -en "\e]P62aa198" # S_cyan
#     echo -en "\e]P8002b36" # S_base03
#     echo -en "\e]P2859900" # S_green
#     echo -en "\e]P5d33682" # S_magenta
#     echo -en "\e]P1dc322f" # S_red
#     echo -en "\e]PC839496" # S_base0
#     echo -en "\e]PE93a1a1" # S_base1
#     echo -en "\e]P9cb4b16" # S_orange
#     echo -en "\e]P7eee8d5" # S_base2
#     echo -en "\e]P4268bd2" # S_blue
#     echo -en "\e]P3b58900" # S_yellow
#     echo -en "\e]PFfdf6e3" # S_base3
#     echo -en "\e]PD6c71c4" # S_violet
#     clear # against bg artifacts
# fi

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/usr/lib/ccache/bin:/usr/local/sbin:/usr/bin/core_perl:/usr/local/bin:/usr/bin:$HOME/.bin:$XDG_CONFIG_HOME/scripts:$HOME/bin:$HOME/.config/composer/vendor/bin:$HOME/.yarn/bin:/usr/bin/vendor_perl"
export XDG_MUSIC_DIR="$HOME/Music"

#export GTK_THEME="E17gtk"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# MAILHOG CONFIG VARIABLES
export MH_STORAGE="maildir"
export MH_MAILDIR_PATH="/tmp/mailhog"

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
#export LESS=" -SRXFN "

export XDEBUG_CONFIG="idekey=VSCODE"

export FREETYPE_PROPERTIES="truetype:interpreter-version=35"

#export MANWIDTH=$(tput cols)

#export CM_DIR="~/.cache/clipmenu"
# Clipmenu Settings
export CM_DEBUG="1"
export CM_SELECTIONS="primary clipboard secondary"

export PAPERSIZE="a4"

# Enable iex shell history
export ERL_AFLAGS="-kernel shell_history enabled"

#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
# Following automatically calls "startx" when you login:
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1

export BROWSER="firefox"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export NNN_USE_EDITOR=1
export PAGER="less"
export LESS="-FJMRWX -x4"
export LC_COLLATE="C"

# NNN
export NNN_CP_MV_PROG=1
export NNN_BMS='s:~/.config/scripts;a:~/.config/awesome;e:/etc;d:~/Downloads;c:~/.config;m:~/media;g:~/Sources'
export NNN_OPENER_DETACH=1
export NNN_TMPFILE="/tmp/nnn"
export NNN_RESTRICT_0B=1
export NNN_SCRIPT="~/.config/nnn/plugins"

# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    # export CLUTTER_BACKEND=wayland
    # export SDL_VIDEODRIVER=wayland
    # XKB_DEFAULT_LAYOUT=us exec sway
    # exec startx > ~/.xorg.log 2>&1
# fi

if [[ -z $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
    # exec xinit -- /usr/bin/Xephyr :78 -nolisten tcp -screen 1366x768 -dpi 96 -rgba rgb -once -tst
    exec startx > $XDG_RUNTIME_DIR/xorg.log 2>&1
fi
