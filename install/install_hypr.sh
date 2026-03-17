#!/usr/bin/env bash
set -euo pipefail

REPO="${HOME}/git/dotfiles"

link_tree() {
    local src="$1"
    local dst="$2"
    mkdir -p "$dst"

    while IFS= read -r -d '' file; do
        local rel="${file#$src/}"
        mkdir -p "$dst/$(dirname "$rel")"
        ln -sfn "$file" "$dst/$rel"
        echo "linked: $dst/$rel -> $file"
    done < <(find "$src" -type f -print0)
}

echo "Installing Hyprland dependencies..."
sudo pacman -S --needed grim slurp wl-clipboard libnotify

echo "Linking repo-managed scripts to ~/.local/bin ..."
link_tree "$REPO/bin" "$HOME/.local/bin"

echo "Linking repo-managed Hyprland config to ~/.config/hypr ..."
link_tree "$REPO/config/hypr" "$HOME/.config/hypr"

echo "Cleaning stale screenshot conf if present..."
rm -f "$HOME/.config/hypr/conf.d/screenshots.conf"

echo "Ensuring executables are executable..."
find "$REPO/bin" -type f -exec chmod +x {} \;

echo "Reloading Hyprland ..."
hyprctl reload || true

echo
echo "Done."
echo "Screenshot binds are now:"
echo "  SUPER + COMMA  -> area"
echo "  SUPER + PERIOD -> active window"
echo "  SUPER + MINUS  -> full screen"
