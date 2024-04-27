#!/bin/sh
# A dmenu binary check-twice script.
# Gives a dmenu prompt labeled with $1 to perform command $2
# Example:
# './check-twice "Do you want to shutdown?" "shutdown -h now"

[ $(echo -e "no\nyes" | rofi -dmenu -p "$1") == "yes" ] && $2
