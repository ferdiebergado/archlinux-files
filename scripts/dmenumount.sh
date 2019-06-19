#!/bin/sh
MDEV=$(ls /media | dmenu -p 'Unmount device:' -i -fn "$DMENU_FONT" -h 32)
[[ -n $MDEV ]] && udevil umount "/media/$MDEV"
