#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

ensure_hyprland_source_line() {
  local hyprland_conf="${HOME}/.config/hypr/hyprland.conf"
  local include_line='source = ~/.config/hypr/conf.d/screenshots.conf'

  mkdir -p "${HOME}/.config/hypr"
  touch "${hyprland_conf}"

  if ! grep -qxF "${include_line}" "${hyprland_conf}"; then
    printf '\n%s\n' "${include_line}" >> "${hyprland_conf}"
    info "Added screenshots include to ${hyprland_conf}"
  fi
}

main() {
  install_pacman_packages grim slurp wl-clipboard jq libnotify

  mkdir -p \
    "${HOME}/.local/bin" \
    "${HOME}/.config/hypr/conf.d" \
    "${HOME}/Pictures/Screenshots"

  link_file "${REPO_DIR}/bin/polarshot" "${HOME}/.local/bin/polarshot"
  make_executable "${REPO_DIR}/bin/polarshot"

  link_file \
    "${REPO_DIR}/config/hypr/conf.d/screenshots.conf" \
    "${HOME}/.config/hypr/conf.d/screenshots.conf"

  ensure_hyprland_source_line

  if command -v hyprctl >/dev/null 2>&1 && [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
    hyprctl reload
  fi
}

main "$@"
