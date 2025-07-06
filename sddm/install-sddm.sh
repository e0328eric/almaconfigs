#!/usr/bin/env bash
sudo pacman -S qt5 sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg 
sudo cp ./almagest-sddm /usr/share/sddm/themes
sudo echo "[Theme]\nCurrent=almagest-sddm\n" > /etc/sddm.conf
