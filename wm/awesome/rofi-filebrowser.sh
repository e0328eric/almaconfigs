#!/bin/sh

rofi -show file-browser-extended                      \
        -file-browser-dir /home/almagest/pCloudDrive  \
        -sorting-method fzf                           \
        -file-browser-depth 7                         \
		-config ~/.config/rofi/rofidmenu.rasi
