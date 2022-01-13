#! /bin/bash
# from https://github.com/hamvocke/dotfiles/blob/master/tmux/tmux_colors.sh

for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
done
