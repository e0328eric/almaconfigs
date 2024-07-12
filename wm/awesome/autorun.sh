#!/bin/sh

function run() {
  if ! pgrep $1 > /dev/null ;
  then
    "$@"&
  fi
}

# run_autostart nitrogen --restore
run fcitx5 -d
run light-locker
run xset s 480 dpms 600 600 600
run picom
run pcloud
