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
  link_file "${REPO_DIR}/bin/random-wallpaper" "${HOME}/.local/bin/random-wallpaper"

  make_executable "${REPO_DIR}/bin/start-hyprland"
  make_executable "${REPO_DIR}/bin/hyprpaper-start"
  make_executable "${REPO_DIR}/bin/random-wallpaper"
}

main "$@"

# DOTFILES_HYPR_LINKS_BEGIN
REPO="${REPO:-$HOME/git/dotfiles}"

mkdir -p "$HOME/.config/hypr" "$HOME/.config/hypr/conf.d" "$HOME/.local/bin"

# Link Hyprland config
ln -sfn "$REPO/config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
ln -sfn "$REPO/config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
ln -sfn "$REPO/config/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"

# Link all repo-managed Hypr helper scripts
for f in "$REPO"/bin/*; do
    [ -f "$f" ] || continue
    chmod +x "$f"
    ln -sfn "$f" "$HOME/.local/bin/$(basename "$f")"
done

echo "Hyprland config and helper scripts linked."
# DOTFILES_HYPR_LINKS_END
