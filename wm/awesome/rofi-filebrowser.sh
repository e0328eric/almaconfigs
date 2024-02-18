#!/bin/sh

rofi -show file-browser-extended                  \
        -file-browser-dir /home/almagest/         \
        -sorting-method fzf                       \
        -file-browser-depth 5                     \
		-config ~/.config/rofi/rofidmenu.rasi
