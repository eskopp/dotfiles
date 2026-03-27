# dotfiles

Basic Wayland / Hyprland dotfiles for Arch Linux.

## Included

- Hyprland
- Hyprpaper
- Hyprlock
- Waybar
- Alacritty
- Dunst
- Rofi
- Fastfetch
- Neovim
- Emacs
- Thunar
- Code - OSS

## Installation

### Local install

Run:

    ./install.sh

### Bootstrap via curl

Run:

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/eskopp/dotfiles/main/bootstrap.sh)" -- \
      https://github.com/eskopp/dotfiles.git

## Wallpapers

Put wallpapers into:

    ~/git/wallpaper

You can switch to a new random wallpaper anytime with:

    SUPER+W

## Start Hyprland

Start Hyprland from a TTY with:

    ~/.local/bin/start-hyprland

## Fastfetch

The installer also installs fastfetch and stows the config to:

    ~/.config/fastfetch/config.jsonc

Run:

    fastfetch
