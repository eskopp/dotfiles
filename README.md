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

Then place a wallpaper here:
~/.config/wallpapers/default.png

Start Hyprland from a TTY with:
~/.local/bin/start-hyprland
