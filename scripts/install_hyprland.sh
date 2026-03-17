#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Load shared helpers if present
if [[ -f "${SCRIPT_DIR}/common.sh" ]]; then
  # shellcheck source=/dev/null
  source "${SCRIPT_DIR}/common.sh"
fi

info() {
  printf '[INFO] %s\n' "$*"
}

link_file() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  info "linked: $dst -> $src"
}

main() {
  info "Installing Hyprland configuration..."

  mkdir -p \
    "$HOME/.config/hypr" \
    "$HOME/.local/bin"

  # Hyprland config files
  link_file "$REPO_DIR/config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
  link_file "$REPO_DIR/config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
  link_file "$REPO_DIR/config/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"

  # Repo-managed helper scripts
  for file in "$REPO_DIR"/bin/*; do
    [[ -f "$file" ]] || continue
    chmod +x "$file"
    link_file "$file" "$HOME/.local/bin/$(basename "$file")"
  done

  info "Hyprland files and helper scripts are ready."
}

main "$@"
