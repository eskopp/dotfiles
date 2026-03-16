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
- Thunar
- Code - OSS

## Install
### Local
Run:
```sh
./install.sh
```

### Bootstrap via curl
Run:
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/eskopp/dotfiles/main/bootstrap.sh)"
```

Then place a fallback wallpaper here (used when no image exists in ~/git/wallpaper):
~/.config/wallpapers/default.png

For random wallpapers on Hyprland startup, place images in:
~/git/wallpaper

You can switch to a new random wallpaper anytime with:
SUPER+W

Start Hyprland from a TTY with:
~/.local/bin/start-hyprland
