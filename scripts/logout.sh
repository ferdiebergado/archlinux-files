#!/bin/bash
tmux kill-server &
[[ $(pgrep -x dwm) -ne 0 ]] && killall -q dwm &
[[ $(pgrep -x awesome) -ne 0 ]] && (echo -e "awesome.quit()" | awesome-client)
exit 0
