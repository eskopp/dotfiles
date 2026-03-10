#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

main() {
  install_pacman_packages rofi
  link_dir "${REPO_DIR}/config/rofi" "${HOME}/.config/rofi"
}

main "$@"
