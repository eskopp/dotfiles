#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"
REPO_CFG="$DOTFILES_DIR/.config/alacritty"
LIVE_CFG="$HOME/.config/alacritty"
TS="$(date +%F-%H%M%S)"

mkdir -p "$HOME/.config"

if [ ! -d "$REPO_CFG" ]; then
    echo "Missing repo config: $REPO_CFG" >&2
    exit 1
fi

if [ -e "$LIVE_CFG" ] && [ ! -L "$LIVE_CFG" ]; then
    mv "$LIVE_CFG" "${LIVE_CFG}.bak.${TS}"
fi

ln -sfn "$REPO_CFG" "$LIVE_CFG"

echo "Linked $LIVE_CFG -> $REPO_CFG"
