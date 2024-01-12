#!/usr/bin/env sh

if [ "$SENDER" = "space_windows_change" ]; then
    space="$(echo "$INFO" | jq -r '.space')"
    apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

    icon_strip=" "
    if [ "${apps}" != "" ]; then
        while read -r app
        do
          icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
        done <<< "${apps}"

        if [ "${icon_strip}" != " " ]; then
            setup=(
                label.drawing=on
                label="$icon_strip"
            )
            sketchybar --set space.$space "${setup[@]}"
        fi
    fi
fi
