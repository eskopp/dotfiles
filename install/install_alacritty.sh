#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"
REPO_DIR="$DOTFILES_DIR/.config/alacritty"
REPO_FILE="$REPO_DIR/alacritty.toml"
LIVE_DIR="$HOME/.config/alacritty"
LIVE_FILE="$LIVE_DIR/alacritty.toml"
OLD_FILE="$HOME/.config/alacritty.toml"
TS="$(date +%F-%H%M%S)"

mkdir -p "$HOME/.config"

if [ ! -f "$REPO_FILE" ]; then
    echo "Missing repo config: $REPO_FILE" >&2
    exit 1
fi

if [ -f "$OLD_FILE" ] && [ ! -L "$OLD_FILE" ]; then
    mv "$OLD_FILE" "${OLD_FILE}.bak.${TS}"
fi

if [ -e "$LIVE_DIR" ] && [ ! -L "$LIVE_DIR" ]; then
    mv "$LIVE_DIR" "${LIVE_DIR}.bak.${TS}"
fi

mkdir -p "$REPO_DIR"
ln -sfn "$REPO_DIR" "$LIVE_DIR"

echo "Linked $LIVE_DIR -> $REPO_DIR"
echo "Active config: $LIVE_FILE"
