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

## Install
### Local
Run:
./install.sh

### Bootstrap via curl
Run (replace `<user>/<repo>`):
sh -c "$(curl -fsSL https://raw.githubusercontent.com/<user>/<repo>/main/bootstrap.sh)" -- \
  https://github.com/<user>/<repo>.git

Then place a wallpaper here:
~/.config/wallpapers/default.png

Start Hyprland from a TTY with:
~/.local/bin/start-hyprland
