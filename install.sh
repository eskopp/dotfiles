#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

info() { printf '\033[1;34m[INFO]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31m[ERROR]\033[0m %s\n' "$*" >&2; exit 1; }

require_arch() {
  [[ -f /etc/arch-release ]] || die "This script only supports Arch Linux."
}

backup_target() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR"/
    info "Backed up $target -> $BACKUP_DIR"
  fi
}

link_dir() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  backup_target "$dst"
  ln -s "$src" "$dst"
  info "Linked $dst -> $src"
}

link_file() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  backup_target "$dst"
  ln -s "$src" "$dst"
  info "Linked $dst -> $src"
}

install_packages() {
  local packages=(
    hyprland
    hyprpaper
    hyprlock
    hyprpolkitagent
    waybar
    rofi
    kitty
    dunst
    thunar
    thunar-volman
    tumbler
    ffmpegthumbnailer
    file-roller
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    qt5-wayland
    qt6-wayland
    qt5ct
    qt6ct
    wl-clipboard
    cliphist
    grim
    slurp
    swappy
    brightnessctl
    pavucontrol
    networkmanager
    network-manager-applet
    wireplumber
    firefox
    fastfetch
    jq
    ttf-font-awesome
    ttf-fira-sans
    ttf-fira-code
    ttf-firacode-nerd
    papirus-icon-theme
  )

  info "Installing packages"
  sudo pacman -S --needed "${packages[@]}"
}

setup_links() {
  mkdir -p \
    "${HOME}/.config" \
    "${HOME}/.config/wallpapers" \
    "${HOME}/.local/bin" \
    "${HOME}/Pictures/Screenshots"

  link_dir  "${REPO_DIR}/config/hypr"   "${HOME}/.config/hypr"
  link_dir  "${REPO_DIR}/config/waybar" "${HOME}/.config/waybar"
  link_dir  "${REPO_DIR}/config/kitty"  "${HOME}/.config/kitty"
  link_dir  "${REPO_DIR}/config/dunst"  "${HOME}/.config/dunst"
  link_dir  "${REPO_DIR}/config/rofi"   "${HOME}/.config/rofi"

  link_file "${REPO_DIR}/bin/start-hyprland"   "${HOME}/.local/bin/start-hyprland"
  link_file "${REPO_DIR}/bin/hyprpaper-start"  "${HOME}/.local/bin/hyprpaper-start"
  link_file "${REPO_DIR}/bin/screenshot-region" "${HOME}/.local/bin/screenshot-region"
  link_file "${REPO_DIR}/bin/power-menu"       "${HOME}/.local/bin/power-menu"
  link_file "${REPO_DIR}/bin/clipboard-menu"   "${HOME}/.local/bin/clipboard-menu"
  link_file "${REPO_DIR}/bin/clipboard-daemon" "${HOME}/.local/bin/clipboard-daemon"

  chmod +x \
    "${REPO_DIR}/bin/start-hyprland" \
    "${REPO_DIR}/bin/hyprpaper-start" \
    "${REPO_DIR}/bin/screenshot-region" \
    "${REPO_DIR}/bin/power-menu" \
    "${REPO_DIR}/bin/clipboard-menu" \
    "${REPO_DIR}/bin/clipboard-daemon"
}

finish() {
  info "Done."
  echo
  echo "Next steps:"
  echo "  1. Put a wallpaper at: ~/.config/wallpapers/default.png"
  echo "  2. Enable NetworkManager:"
  echo "     sudo systemctl enable --now NetworkManager"
  echo "  3. Start Hyprland from TTY:"
  echo "     ~/.local/bin/start-hyprland"
}

main() {
  require_arch
  sudo -v
  install_packages
  setup_links
  finish
}

main "$@"
