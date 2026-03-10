#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

main() {
  install_pacman_packages \
    thunar \
    thunar-volman \
    tumbler \
    ffmpegthumbnailer \
    file-roller
}

main "$@"
