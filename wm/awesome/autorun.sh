#!/bin/sh

function run() {
  if ! pgrep $1 > /dev/null ;
  then
    "$@"&
  fi
}

# run ibus
run ibus-daemon -rxRd

# adjust brightness
run awesome-brightness 0

# lightdm locker enable
run light-locker

# set powersavings for display
run xset s 480 dpms 600 600 600

# load nextcloud
run nextcloud
