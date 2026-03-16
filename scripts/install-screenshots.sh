#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

main() {
  install_pacman_packages grim slurp wl-clipboard jq libnotify

  mkdir -p \
    "${HOME}/.local/bin" \
    "${HOME}/Pictures/Screenshots"

  # Heal partial setups: keep ~/.config/hypr linked to the repo so conf.d and
  # the rest of Hyprland config stay consistent.
  link_dir "${REPO_DIR}/config/hypr" "${HOME}/.config/hypr"

  link_file "${REPO_DIR}/bin/polarshot" "${HOME}/.local/bin/polarshot"
  link_file "${REPO_DIR}/bin/hyprpaper-start" "${HOME}/.local/bin/hyprpaper-start"
  link_file "${REPO_DIR}/bin/random-wallpaper" "${HOME}/.local/bin/random-wallpaper"

  make_executable "${REPO_DIR}/bin/polarshot"
  make_executable "${REPO_DIR}/bin/hyprpaper-start"
  make_executable "${REPO_DIR}/bin/random-wallpaper"

  if command -v hyprctl >/dev/null 2>&1 && [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
    hyprctl reload
  fi
}

main "$@"
