#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

info() {
  printf '[INFO] %s\n' "$*"
}

main() {
  info "Finalizing screenshot setup..."

  if [[ -f "$REPO_DIR/bin/polarshot" ]]; then
    chmod +x "$REPO_DIR/bin/polarshot"
  fi

  if [[ -f "$REPO_DIR/bin/screenshot-region" ]]; then
    chmod +x "$REPO_DIR/bin/screenshot-region"
  fi

  mkdir -p "$HOME/Pictures/Screenshots"

  info "Screenshot setup is ready."
}

main "$@"
