#!/bin/sh
nitrogen & disown
picom & disown # --experimental-backends --vsync should prevent screen tearing on most setups if needed
light-locker & disown

# dim on the startup
~/.config/qtile/scripts/dim_at_startup.sh & disown

# Low battery notifier
~/.config/qtile/scripts/check_battery.sh & disown

# Start welcome
eos-welcome & disown
nimf & disown
pcloud & disown

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown # start polkit agent from GNOME
