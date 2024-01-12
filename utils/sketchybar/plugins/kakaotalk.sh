#!/usr/bin/env sh

source "$CONFIG_DIR/colors.sh"

STATUS_LABEL=$(lsappinfo info -only StatusLabel "KakaoTalk")
ICON=$($CONFIG_DIR/plugins/icon_map.sh "KakaoTalk")
if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"

    if [[ $LABEL == "" ]]; then
        ICON_COLOR=$GREEN
    elif [[ $LABEL == "•" ]]; then
        ICON_COLOR=$ORANGE
    elif [[ $LABEL =~ ^[0-9]+$ ]]; then
        ICON_COLOR=$RED
    else
        exit 0
    fi
else
    sketchybar --set $NAME icon=$ICON label.drawing=off icon.color=$GREEN
    exit 0
fi

sketchybar --set $NAME icon=$ICON       \
                       label.drawing=on \
                       label="${LABEL}" \
                       icon.color=${ICON_COLOR}
