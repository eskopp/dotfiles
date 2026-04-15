# dotfiles

Personal Arch Linux dotfiles for a Wayland desktop built around **Hyprland** and a consistent **Nord** look.

## Features

- Hyprland-based Wayland desktop
- Static Nord styling across the desktop
- GNU Stow-based installation
- Custom helper scripts for wallpapers, screenshots, clipboard, Wi-Fi, Bluetooth, and power actions
- Fast terminal workflow with Alacritty, Zsh, Fastfetch, and Neovim

## Included

This repository currently includes configuration for:

- Hyprland
- Hyprpaper
- Hyprlock
- imv
- Waybar
- Alacritty
- Dunst
- Rofi
- Fastfetch
- Neovim
- Emacs
- Thunar
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

## Wallpaper

The desktop uses fixed images stored directly in the repo:

    hypr/hypr/background.png
    hypr/hypr/lockscreen.png

After stowing they are available as:

    ~/.config/hypr/background.png
    ~/.config/hypr/lockscreen.png

You can re-apply the desktop wallpaper at any time with:

    SUPER+W

## Start Hyprland

Start Hyprland from a TTY with:

    ~/.local/bin/start-hyprland

## Image viewer

imv is included as a lightweight image viewer. It supports keyboard navigation and can show the current image path as an overlay.

Run:

    imv .

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
- `local-bin/` → helper scripts
- `scripts/` → install helpers

## Notes

- This setup is intended for **Arch Linux**.
- GNU Stow is used to manage symlinked configuration files.
- Wallpapers are not included in this repository.
