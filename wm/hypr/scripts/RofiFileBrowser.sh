#!/bin/sh

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

rofi -modi file-browser-extended                   \
     -show file-browser-extended                   \
     -file-browser-dir /home/almagest/pCloudDrive  \
     -sorting-method fzf                           \
     -file-browser-depth 7
