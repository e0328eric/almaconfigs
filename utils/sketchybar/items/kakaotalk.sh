#!/usr/bin/env sh

kakao_talk=(
    update_freq=10
    icon.font="sketchybar-app-font:Regular:16.0"
    click_script="open -a KakaoTalk"
    script="$PLUGIN_DIR/kakaotalk.sh"
)

sketchybar --add item kakaotalk right          \
           --set kakaotalk "${kakao_talk[@]}"  \
           --subscribe kakaotalk system_woke
