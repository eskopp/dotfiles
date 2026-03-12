#!/usr/bin/env bash
set -euo pipefail

if command -v paru >/dev/null 2>&1; then
    paru -S --needed wallust
elif command -v yay >/dev/null 2>&1; then
    yay -S --needed wallust
elif command -v cargo >/dev/null 2>&1; then
    cargo install wallust
else
    echo "No supported installer found." >&2
    echo "Install paru, yay, or cargo first." >&2
    exit 1
fi
