#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$REPO_DIR/.config/waybar"
TARGET_DIR="$HOME/.config/waybar"

mkdir -p "$HOME/.config"

if [ ! -d "$SRC_DIR" ]; then
    echo "Waybar repo config not found: $SRC_DIR" >&2
    exit 1
fi

if [ -e "$TARGET_DIR" ] && [ ! -L "$TARGET_DIR" ]; then
    BACKUP="${TARGET_DIR}.bak-$(date +%Y%m%d-%H%M%S)"
    echo "Backing up $TARGET_DIR -> $BACKUP"
    mv "$TARGET_DIR" "$BACKUP"
fi

ln -sfn "$SRC_DIR" "$TARGET_DIR"
echo "Linked $TARGET_DIR -> $SRC_DIR"

if pgrep -x waybar >/dev/null 2>&1; then
    pkill -x waybar || true
    nohup waybar >/dev/null 2>&1 &
    echo "Restarted Waybar"
else
    echo "Waybar is not running right now."
fi
