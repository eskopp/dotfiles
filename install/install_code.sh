#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SYS_CODE_HOME="$HOME/.config/Code - OSS/User"
REPO_CODE_HOME="$REPO/config/code-oss/User"

backup_item() {
  local target="$1"
  if [ -L "$target" ]; then
    rm -f "$target"
  elif [ -e "$target" ]; then
    mv "$target" "${target}.bak.$(date +%Y%m%d-%H%M%S)"
  fi
}

if ! command -v pacman >/dev/null 2>&1; then
  echo "This installer supports Arch Linux with pacman."
  exit 1
fi

sudo pacman -S --needed code

mkdir -p "$SYS_CODE_HOME" "$REPO_CODE_HOME" "$REPO_CODE_HOME/snippets"

[ -f "$REPO_CODE_HOME/settings.json" ] || printf '{}\n' > "$REPO_CODE_HOME/settings.json"
[ -f "$REPO_CODE_HOME/keybindings.json" ] || printf '[]\n' > "$REPO_CODE_HOME/keybindings.json"

backup_item "$SYS_CODE_HOME/settings.json"
backup_item "$SYS_CODE_HOME/keybindings.json"
backup_item "$SYS_CODE_HOME/snippets"

ln -sfn "$REPO_CODE_HOME/settings.json" "$SYS_CODE_HOME/settings.json"
ln -sfn "$REPO_CODE_HOME/keybindings.json" "$SYS_CODE_HOME/keybindings.json"
ln -sfn "$REPO_CODE_HOME/snippets" "$SYS_CODE_HOME/snippets"

echo "Code - OSS installation and dotfile links are ready."
