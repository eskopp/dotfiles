#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${REPO_DIR}/scripts/common.sh"

main() {
  require_arch
  require_sudo
  start_sudo_keepalive
  trap stop_sudo_keepalive EXIT
  ensure_base_dirs

  bash "${REPO_DIR}/scripts/install_core.sh"
  bash "${REPO_DIR}/scripts/install_hyprland.sh"
  bash "${REPO_DIR}/scripts/install_waybar.sh"
  bash "${REPO_DIR}/scripts/install_alacritty.sh"
  bash "${REPO_DIR}/scripts/install_dunst.sh"
  bash "${REPO_DIR}/scripts/install_rofi.sh"
  bash "${REPO_DIR}/scripts/install_thunar.sh"
  bash "${REPO_DIR}/scripts/install_tools.sh"

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
