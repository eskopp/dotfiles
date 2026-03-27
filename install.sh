#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${REPO_DIR}/scripts/common.sh"

install_required_packages() {
  install_pacman_packages \
    stow \
    qt5-wayland \
    qt6-wayland \
    qt5ct \
    qt6ct \
    iwd \
    wireplumber \
    firefox \
    fastfetch \
    jq \
    papirus-icon-theme \
    ttf-font-awesome \
    ttf-fira-sans \
    ttf-fira-code \
    ttf-firacode-nerd \
    hyprland \
    hyprpaper \
    hyprlock \
    hyprpolkitagent \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    waybar \
    alacritty \
    dunst \
    rofi \
    thunar \
    thunar-volman \
    tumbler \
    ffmpegthumbnailer \
    file-roller \
    wl-clipboard \
    cliphist \
    grim \
    slurp \
    swappy \
    brightnessctl \
    pavucontrol \
    wtype \
    libnotify \
    blueman \
    zsh \
    git \
    curl \
    zoxide \
    code \
    neovim \
    emacs-wayland \
    python
}

main() {
  require_arch
  require_sudo
  start_sudo_keepalive
  trap stop_sudo_keepalive EXIT

  ensure_base_dirs
  install_required_packages

  bash "${REPO_DIR}/scripts/install_zsh.sh"

  prepare_stow_tree
  backup_stow_targets
  stow_packages

  info "All installers finished successfully."
  printf '\n'
  printf 'Next steps:\n'
  printf '  1. Put wallpapers into: %s\n' "${HOME}/git/wallpaper"
  printf '  2. Enable Wi-Fi management if needed:\n'
  printf '     sudo systemctl enable --now iwd\n'
  printf '  3. Start Hyprland from a TTY with:\n'
  printf '     %s\n' "${HOME}/.local/bin/start-hyprland"
  printf '  4. Check Fastfetch with:\n'
  printf '     fastfetch\n'
}

main "$@"
