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

## Wi-Fi

This setup uses `iwd` / `iwctl` and does **not** use NetworkManager.

Enable Wi-Fi management with:

```sh
sudo systemctl enable --now iwd
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
