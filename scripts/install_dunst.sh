#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

main() {
  install_pacman_packages dunst
  link_dir "${REPO_DIR}/config/dunst" "${HOME}/.config/dunst"
}

main "$@"
