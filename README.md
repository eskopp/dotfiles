# dotfiles

Personal Arch Linux dotfiles for a Wayland desktop built around Hyprland.

## Included

This setup currently includes configuration for:

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
- theme-switcher
- custom local scripts

## Installation

### Local install

Clone the repository and run:

    ./install.sh

### Bootstrap via curl

Run:

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/eskopp/dotfiles/main/bootstrap.sh)" -- \
      https://github.com/eskopp/dotfiles.git

## Wallpapers

Wallpapers are expected in:

    ~/git/wallpaper

A random wallpaper can be applied at any time with:

    SUPER+W

Some themes can also use theme-specific wallpaper subfolders, for example:

    ~/git/wallpaper/nord
    ~/git/wallpaper/anime
    ~/git/wallpaper/berserk
    ~/git/wallpaper/solstice

## Theme switching

The setup includes a theme switcher for shared colors across the desktop.

Available themes are stored in:

    ~/.config/theme-switcher/themes

You can open the theme switcher with:

    ~/.local/bin/theme-switcher

Or apply a theme directly with:

    ~/.local/bin/theme-apply <theme-name>

## Start Hyprland

Start Hyprland from a TTY with:

    ~/.local/bin/start-hyprland

## Fastfetch

The installer also installs Fastfetch and links the config to:

    ~/.config/fastfetch/config.jsonc

Run:

    fastfetch

## Notes

- The install script is intended for Arch Linux.
- GNU Stow is used to manage the linked configuration files.
- Some theme-dependent files are generated dynamically when a theme is applied.
