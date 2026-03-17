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
    "${HOME}/.config/dunst"
    "${HOME}/.config/Code - OSS/User"
    "${HOME}/.local/bin"
  )

  local dir
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
  remove_empty_dirs
  rm -rf "${STOW_BUILD_DIR}"

  info "Done."
  info "Repo-managed stow links were removed."
}

main "$@"
