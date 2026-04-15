# dotfiles

Personal Arch Linux dotfiles for a Wayland desktop built around **Hyprland** and a consistent **Nord** look.

## Features

- Hyprland-based Wayland desktop
- Static Nord styling across the desktop
- GNU Stow-based installation
- Custom helper scripts for wallpapers, screenshots, clipboard, Wi-Fi, Bluetooth, and power actions
- Fast terminal workflow with Alacritty, Zsh, Fastfetch, and Neovim
- Optional GUI editor setup for Code - OSS

## Included

This repository currently includes configuration for:

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
- Zsh
- Bash
- local helper scripts

## Installation

### Local install

Clone the repository and run:
```sh
    ./install.sh
```

### Bootstrap via curl

Run:
```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/eskopp/dotfiles/main/bootstrap.sh)" -- \
      https://github.com/eskopp/dotfiles.git
```

## Wallpapers

Wallpapers are expected in:

    ~/git/wallpaper

A random wallpaper can be applied at any time with:

    SUPER+W

## Start Hyprland

Start Hyprland from a TTY with:

    ~/.local/bin/start-hyprland

## Fastfetch

The installer also installs Fastfetch and links the config to:

    ~/.config/fastfetch/config.jsonc

Run:

    fastfetch

## Repository layout

- `hypr/` → Hyprland, Hyprpaper, Hyprlock
- `waybar/` → Waybar config and styling
- `rofi/` → launcher config
- `dunst/` → notification styling
- `alacritty/` → terminal config
- `nvim/` → Neovim config
- `zsh/` → shell config and prompt
- `code-oss/` → user settings
- `code-oss-theme/` → local Code - OSS themes
- `local-bin/` → helper scripts
- `scripts/` → install helpers

## Notes

- This setup is intended for **Arch Linux**.
- GNU Stow is used to manage symlinked configuration files.
- Wallpapers are not included in this repository.
