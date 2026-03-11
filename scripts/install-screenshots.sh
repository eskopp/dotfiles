#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p \
    "$HOME/.local/bin" \
    "$HOME/.config/hypr/conf.d" \
    "$HOME/Pictures/Screenshots"

if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed grim slurp wl-clipboard jq libnotify
fi

ln -sf "$repo_root/.local/bin/polarshot" "$HOME/.local/bin/polarshot"
ln -sf "$repo_root/.config/hypr/conf.d/screenshots.conf" "$HOME/.config/hypr/conf.d/screenshots.conf"

mkdir -p "$HOME/.config/hypr"
touch "$HOME/.config/hypr/hyprland.conf"

grep -qxF 'source = ~/.config/hypr/conf.d/screenshots.conf' "$HOME/.config/hypr/hyprland.conf" \
    || printf '\nsource = ~/.config/hypr/conf.d/screenshots.conf\n' >> "$HOME/.config/hypr/hyprland.conf"

if command -v hyprctl >/dev/null 2>&1 && [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
    hyprctl reload
fi
