# hyprland settings

## Required packages

Here is a list of packages this hyprland config requires.
Notice that the list might not contain some packages but it is required.

- brightnessctl
- cliphist
- dunst
- fcitx5
- fcitx5-hangul
- ghostty
- grim (screen capturing)
- hypridle
- hyprlock
- icedrive
- keyd
- nwg-displays
- pamixer
- playerctl
- swww
- thunar
- ttf-jetbrains-mono-nerd
- vivaldi
- walker
- wallust (AUR)
- waybar

## monitor settings

use `nwg-displays` to set monitors

## change keybindings using keyd

copy `./keyd/default.conf` inside `/etc/keyd/default.conf`.
Then run `sudo systemd enable keyd --now`.
