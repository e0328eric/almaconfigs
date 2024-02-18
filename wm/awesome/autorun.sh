#!/bin/sh

function run() {
  if ! pgrep $1 > /dev/null ;
  then
    "$@"&
  fi
}

# lightdm locker enable
run light-locker

# set powersavings for display
run xset s 480 dpms 600 600 600

# load nextcloud
run nextcloud
