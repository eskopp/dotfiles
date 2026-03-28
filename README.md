# dotfiles

Personal Arch Linux dotfiles for a Wayland desktop built around **Hyprland**.

This setup focuses on a themed, keyboard-friendly workflow with shared styling across the terminal, launcher, bar, notifications, shell prompt, and editor tooling.

## Features

- Hyprland-based Wayland desktop
- Shared theme system across multiple applications
- GNU Stow-based installation
- Custom helper scripts for wallpapers, screenshots, clipboard, Wi-Fi, Bluetooth, and power actions
- Fast terminal workflow with Alacritty, Zsh, Fastfetch, and Neovim
- Optional GUI editor setup for Code - OSS
- Multiple desktop themes with a single theme switcher

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
- theme-switcher
- local helper scripts

## Themes

The desktop theme system is shared across multiple components.

Currently available themes include:

- `nord`
- `anime`
- `berserk`
- `solstice`

The active theme affects parts of the desktop such as:

- Waybar
- Rofi
- Dunst
- Alacritty
- Fastfetch
- Hyprland colors
- shell prompt
- Neovim
- Code - OSS

## Installation

### Local install

Clone the repository and run:

    ./install.sh

### Bootstrap via curl

Run:

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/eskopp/dotfiles/main/bootstrap.sh)" -- \
      https://github.com/eskopp/dotfiles.git

## Theme switching

Open the interactive theme switcher with:

    ~/.local/bin/theme-switcher

Apply a theme directly with:

    ~/.local/bin/theme-apply <theme-name>

Theme definitions live in:

    ~/.config/theme-switcher/themes

## Wallpapers

Wallpapers are expected in:

    ~/git/wallpaper

A random wallpaper can be applied at any time with:

    SUPER+W

Theme-specific wallpaper folders can also be used, for example:

    ~/git/wallpaper/nord
    ~/git/wallpaper/anime
    ~/git/wallpaper/berserk
    ~/git/wallpaper/solstice

## Start Hyprland

Start Hyprland from a TTY with:

    ~/.local/bin/start-hyprland

## Fastfetch

The installer also installs Fastfetch and links the config to:

    ~/.config/fastfetch/config.jsonc

Run:

    fastfetch

## Repository layout

A simplified overview of the main structure:

- `hypr/` → Hyprland, Hyprpaper, Hyprlock
- `waybar/` → Waybar config and styling
- `rofi/` → launcher config
- `dunst/` → notification styling
- `alacritty/` → terminal config
- `nvim/` → Neovim config
- `zsh/` → shell config and prompt
- `code-oss/` → user settings
- `code-oss-theme/` → local Code - OSS themes
- `theme-switcher/` → shared theme files
- `local-bin/` → helper scripts
- `scripts/` → install helpers

## Notes

- This setup is intended for **Arch Linux**.
- GNU Stow is used to manage symlinked configuration files.
- Some files are generated dynamically when a theme is applied.
- Wallpapers are not included in this repository.
