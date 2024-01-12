#!/usr/bin/env sh

volume=(
    padding_left=10
    icon.font="$FONT:SemiBold:14.0"
    label.font="$FONT:Regular:14.0"
    script="$PLUGIN_DIR/volume.sh"
)

status_bracket=(
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
    background.border_width=2
)

sketchybar --add item volume right             \
           --set volume "${volume[@]}"         \
           --subscribe volume volume_change

sketchybar --add bracket status battery brew kakaotalk volume \
           --set status "${status_bracket[@]}"
