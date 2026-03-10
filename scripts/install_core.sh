#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

main() {
  install_pacman_packages \
    qt5-wayland \
    qt6-wayland \
    qt5ct \
    qt6ct \
    networkmanager \
    network-manager-applet \
    wireplumber \
    firefox \
    fastfetch \
    jq \
    papirus-icon-theme \
    ttf-font-awesome \
    ttf-fira-sans \
    ttf-fira-code \
    ttf-firacode-nerd
}

main "$@"
