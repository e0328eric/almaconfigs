#!/usr/bin/env bash

set -xe

# AlmaArch Configuration
# This configuration assumes that user is already defined and the user can use sudo

ALMACONF="$HOME/.almaconf"

# prevent to runu this script on root
if [ "$EUID" -eq 0 ]; then
    echo "Do not run this script as root."
    exit 1
fi

sudo -v

# add refind theme
THEME="refind_almagest"
REFIND="/boot/EFI/refind"
CONF="$REFIND/refind.conf"
LINE="include themes/$THEME/theme.conf"

if [[ ! -d "$REFIND/themes/$THEME" ]]; then
    sudo mkdir -p "$REFIND/themes"
    sudo cp -r "$ALMACONF/refind/$THEME" "$REFIND/themes"
    sudo grep -qxF "$LINE" "$CONF" 2>/dev/null || \
        echo "$LINE" | sudo tee -a "$CONF" >/dev/null
fi

# instsall rust to install paru
if ! command -v rustup >/dev/null 2>&1; then
    sudo pacman -S --noconfirm --needed rustup
    rustup default stable
fi

# install paru
sudo pacman -S --noconfirm --needed base-devel
if ! command -v paru >/dev/null 2>&1; then
    git clone --depth 1 https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
    rm -rf paru
fi

sudo pacman -Syyu

#          ╭──────────────────────────────────────────────────────────╮
#          │                     install packages                     │
#          ╰──────────────────────────────────────────────────────────╯
sudo pacman -S --noconfirm --needed \
    git cmake make gcc keyd bat lazygit libsecret gnome-keyring \
    ufw

# enable gnome keyrings
systemctl --user enable gnome-keyring-daemon
systemctl --user start gnome-keyring-daemon

#          ╭──────────────────────────────────────────────────────────╮
#          │                       setting keyd                       │
#          ╰──────────────────────────────────────────────────────────╯
sudo cp "$ALMACONF/keyboard/keyd/default.conf" "/etc/keyd/default.conf"
sudo systemctl enable keyd --now

#          ╭──────────────────────────────────────────────────────────╮
#          │                   install sddm stuffs                    │
#          ╰──────────────────────────────────────────────────────────╯
sudo pacman -S --noconfirm --needed \
    sddm qt6 qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg

sudo systemctl enable sddm
if [[ ! -d "/usr/share/sddm/themes/almagest-sddm" ]]; then
    sudo cp -r "$ALMACONF/sddm/almagest-sddm" "/usr/share/sddm/themes"
    sudo cp "$ALMACONF/sddm/sddm.conf" "/etc/sddm.conf"
fi

#          ╭──────────────────────────────────────────────────────────╮
#          │                        bluetooth                         │
#          ╰──────────────────────────────────────────────────────────╯
sudo pacman -S --noconfirm --needed \
    pipewire wireplumber pipewire-alsa pipewire-pulse rtkit \
    bluez bluez-utils lib32-alsa-plugins pavucontrol

sudo systemctl enable --now rtkit-daemon.service

# in this setting, sound is weird
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo tee /etc/pipewire/pipewire.conf.d/92-low-latency.conf >/dev/null <<'EOF'
context.properties = {
  default.clock.rate = 48000
  default.clock.quantum = 1024
  default.clock.min-quantum = 512
  default.clock.max-quantum = 2048
}
EOF

sudo mkdir -p /etc/wireplumber/wireplumber.conf.d
sudo tee /etc/wireplumber/wireplumber.conf.d/50-bluez-properties.conf >/dev/null <<'EOF'
monitor.bluez.properties = {
  bluez5.enable-sbc-xq = false
  bluez5.enable-msbc = true
  bluez5.enable-hw-volume = true
  bluez5.roles = [ a2dp_sink a2dp_source hsp_hs hsp_ag hfp_hf hfp_ag ]
}
EOF

systemctl --user enable --now pipewire pipewire-pulse wireplumber

#          ╭──────────────────────────────────────────────────────────╮
#          │                 install hyprland stuffs                  │
#          ╰──────────────────────────────────────────────────────────╯
sudo pacman -S --noconfirm --needed \
    hyprland ghostty tree-sitter tree-sitter-cli neovim nodejs \
    hyprlock hypridle brightnessctl fcitx5 fcitx5-hangul fcitx5-config-qt \
    grim nwg-displays pamixer playerctl nemo ttf-jetbrains-mono-nerd \
    vivaldi cliphist grimblast-git wl-clipboard starship zenith

paru -S --noconfirm --needed vicinae awww-git noctalia-shell \
    synology-drive mimeo

#          ╭──────────────────────────────────────────────────────────╮
#          │                install several utilities                 │
#          ╰──────────────────────────────────────────────────────────╯
sudo pacman -S --noconfirm --needed \
    steam mpv zathura zathura-djvu zathura-pdf-mupdf

#          ╭──────────────────────────────────────────────────────────╮
#          │                      make symlinks                       │
#          ╰──────────────────────────────────────────────────────────╯
CONFIG="$HOME/.config"

# if fish config is already installed, remove it.
rm -rf "$CONFIG/fish"

link_if_missing() {
    local target="$1"
    local link="$2"

    if [[ ! -e "$link" ]]; then
        ln -s "$target" "$link"
    fi
}

link_if_missing "$ALMACONF/wm/hypr"             "$CONFIG/hypr"
link_if_missing "$ALMACONF/utils/nvim"          "$CONFIG/nvim"
link_if_missing "$ALMACONF/shell/fish"          "$CONFIG/fish"
link_if_missing "$ALMACONF/shell/nushell_linux" "$CONFIG/nushell"
link_if_missing "$ALMACONF/terminals/kitty"     "$CONFIG/kitty"
link_if_missing "$ALMACONF/terminals/ghostty"   "$CONFIG/ghostty"
link_if_missing "$ALMACONF/utils/noctalia"      "$CONFIG/noctalia"

# wallpapers
link_if_missing "$ALMACONF/wallpapers" "$CONFIG/alma-wallpapers"

#          ╭──────────────────────────────────────────────────────────╮
#          │                       git settings                       │
#          ╰──────────────────────────────────────────────────────────╯
#
# Set global Git identity
git config --global user.name "Sungbae Jeong"
git config --global user.email "almagest0328@gmail.com"

# Set credential helper to libsecret
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

#          ╭──────────────────────────────────────────────────────────╮
#          │                install prebuilt binaries                 │
#          ╰──────────────────────────────────────────────────────────╯
# make ~/.local/bin
if [[ ! -d "$HOME/.local/bin" ]]; then
    mkdir "$HOME/.local/bin"
fi
for target in "$HOME/.almaconf/bin/"*; do
    link="$HOME/.local/bin/$(basename "$target")"
    link_if_missing "$target" "$link"
done
