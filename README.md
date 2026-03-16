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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/eskopp/dotfiles/main/bootstrap.sh)"
```

## Wallpaper setup

### Random wallpapers (Hyprland startup + `SUPER+W`)

The setup expects your wallpaper collection in:

```sh
~/git/wallpaper
```

On every Hyprland start, a random image from that folder is set.

You can switch to another random wallpaper anytime with:

- `SUPER+W`

### Fallback wallpaper

If no image is available in `~/git/wallpaper`, this fallback is used:

```sh
~/.config/wallpapers/default.png
```

## Start Hyprland

Start Hyprland from a TTY with:

```sh
~/.local/bin/start-hyprland
```
