#!/bin/bash
# Bash script to control the monitor brightness
brightness_level=0.6
screenname=$(xrandr | grep " connected" | cut -f1 -d" ")
xrandr --output $screenname --brightness $brightness_level;
