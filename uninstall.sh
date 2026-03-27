#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${REPO_DIR}/scripts/common.sh"

remove_empty_dirs() {
  local dirs=(
    "${HOME}/.config/hypr"
    "${HOME}/.config/waybar"
    "${HOME}/.config/rofi"
    "${HOME}/.config/alacritty"
    "${HOME}/.config/dunst/dunstrc.d"
    "${HOME}/.config/dunst"
    "${HOME}/.config/fastfetch"
    "${HOME}/.config/nvim"
    "${HOME}/.config/emacs"
    "${HOME}/.config/theme-switcher/fastfetch-logos"
    "${HOME}/.config/theme-switcher"
    "${HOME}/.config/Code - OSS/User"
    "${HOME}/.vscode-oss/extensions"
    "${HOME}/.local/bin"
  )

  for dir in "${dirs[@]}"; do
    while [[ "${dir}" != "${HOME}" && "${dir}" != "/" ]]; do
      if [[ -d "${dir}" && -z "$(ls -A "${dir}" 2>/dev/null)" ]]; then
        rmdir "${dir}" 2>/dev/null || true
        dir="$(dirname "${dir}")"
      else
        break
      fi
    done
  done
}

main() {
  prepare_stow_tree
  unstow_packages

  rm -f "${HOME}/.vscode-oss/extensions/polar-nord"
  rm -f "${HOME}/.config/dunst/dunstrc.d/99-theme.conf"
  rm -rf "${HOME}/.config/theme-switcher/current"

  remove_empty_dirs
  rm -rf "${STOW_BUILD_DIR}"

  info "Done."
  info "Repo-managed stow links were removed."
}

main "$@"
