#!/bin/sh
export FILENAME=$(date +%Y-%m-%d-%T) 
export FILEPATH="/tmp/$FILENAME"
scrot -t 10 /tmp/$FILENAME.png 
mv $FILEPATH.png ~/Pictures/screenshots/
notify-send -i "$PATH-thumb.png" "SCREENSHOT" "Saved to ~/Pictures/screenshots/$FILENAME.png"
