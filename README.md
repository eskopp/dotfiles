# dotfiles

Basic Wayland / Hyprland dotfiles for Arch Linux.

## Included

- `Hyprland`
- `Hyprpaper`
- `Hyprlock`
- `Waybar`
- `Alacritty`
- `Dunst`
- `Rofi`
- `Thunar`
- `Code - OSS`

## Installation

### Local install

Run:

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

Put wallpapers into:

```sh
~/git/wallpaper
```

You can switch to a new random wallpaper anytime with:

```text
SUPER+W
```

## Start Hyprland

Start Hyprland from a TTY with:

```sh
~/.local/bin/start-hyprland
```
