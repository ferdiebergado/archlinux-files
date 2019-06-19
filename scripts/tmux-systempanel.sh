#!/bin/sh
tmux new -s system_monitor -d htop
#tmux send-keys -t system_monitor "htop" C-m
tmux split-window -v -t system_monitor
tmux send-keys -t system_monitor "journalctl -f" C-m
tmux split-window -v -t system_monitor
#tmux send-keys -t system_monitor "tailf $XDG_RUNTIME_DIR/stdout" C-m
tmux split-window -h -t system_monitor
#tmux send-keys -t system_monitor "tailf $XDG_RUNTIME_DIR/stderr" C-m
#tmux selectp -t system_monitor 0
tmux -2u attach -t system_monitor

