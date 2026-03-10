#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

main() {
  install_pacman_packages \
    hyprland \
    hyprpaper \
    hyprlock \
    hyprpolkitagent \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk

  link_dir "${REPO_DIR}/config/hypr" "${HOME}/.config/hypr"
  link_file "${REPO_DIR}/bin/start-hyprland" "${HOME}/.local/bin/start-hyprland"
  link_file "${REPO_DIR}/bin/hyprpaper-start" "${HOME}/.local/bin/hyprpaper-start"

  make_executable "${REPO_DIR}/bin/start-hyprland"
  make_executable "${REPO_DIR}/bin/hyprpaper-start"
}

main "$@"
