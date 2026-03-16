#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${REPO_DIR}/scripts/common.sh"

install_required_packages() {
  install_pacman_packages \
    qt5-wayland \
    qt6-wayland \
    qt5ct \
    qt6ct \
    networkmanager \
    network-manager-applet \
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
    zsh \
    git \
    curl \
    zoxide
}

main() {
  require_arch
  require_sudo
  start_sudo_keepalive
  trap stop_sudo_keepalive EXIT
  ensure_base_dirs
  install_required_packages

  bash "${REPO_DIR}/scripts/install_core.sh"
  bash "${REPO_DIR}/scripts/install_hyprland.sh"
  bash "${REPO_DIR}/scripts/install_waybar.sh"
  bash "${REPO_DIR}/scripts/install_alacritty.sh"
  bash "${REPO_DIR}/scripts/install_dunst.sh"
  bash "${REPO_DIR}/scripts/install_rofi.sh"
  bash "${REPO_DIR}/scripts/install_thunar.sh"
  bash "${REPO_DIR}/scripts/install_tools.sh"

  if [[ -f "${REPO_DIR}/scripts/install_zsh.sh" ]]; then
    bash "${REPO_DIR}/scripts/install_zsh.sh"
  fi

  if [[ -f "${REPO_DIR}/scripts/install_code.sh" ]]; then
    bash "${REPO_DIR}/scripts/install_code.sh"
  fi

  bash "${REPO_DIR}/scripts/install-screenshots.sh"

  info "All installers finished successfully."
  printf '\n'
  printf 'Next steps:\n'
  printf '  1. Put a wallpaper at: %s\n' "${HOME}/.config/wallpapers/default.png"
  printf '  2. Enable NetworkManager if needed:\n'
  printf '     sudo systemctl enable --now NetworkManager\n'
  printf '  3. Start Hyprland from a TTY with:\n'
  printf '     %s\n' "${HOME}/.local/bin/start-hyprland"
}

main "$@"
