#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

main() {
  install_pacman_packages \
    wl-clipboard \
    cliphist \
    grim \
    slurp \
    swappy \
    brightnessctl \
    pavucontrol \
    wtype \
    blueman

  link_file "${REPO_DIR}/bin/screenshot-region" "${HOME}/.local/bin/screenshot-region"
  link_file "${REPO_DIR}/bin/power-menu" "${HOME}/.local/bin/power-menu"
  link_file "${REPO_DIR}/bin/clipboard-menu" "${HOME}/.local/bin/clipboard-menu"
  link_file "${REPO_DIR}/bin/clipboard-daemon" "${HOME}/.local/bin/clipboard-daemon"
  link_file "${REPO_DIR}/bin/bluetooth-menu" "${HOME}/.local/bin/bluetooth-menu"

  make_executable "${REPO_DIR}/bin/screenshot-region"
  make_executable "${REPO_DIR}/bin/power-menu"
  make_executable "${REPO_DIR}/bin/clipboard-menu"
  make_executable "${REPO_DIR}/bin/clipboard-daemon"
  make_executable "${REPO_DIR}/bin/bluetooth-menu"
}

main "$@"
