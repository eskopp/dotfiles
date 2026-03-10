#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_ROOT="${HOME}/.dotfiles-backup"
BACKUP_DIR="${BACKUP_ROOT}/$(date +%Y%m%d-%H%M%S)"

info() {
  printf '\033[1;34m[INFO]\033[0m %s\n' "$*"
}

warn() {
  printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2
}

die() {
  printf '\033[1;31m[ERROR]\033[0m %s\n' "$*" >&2
  exit 1
}

require_arch() {
  [[ -f /etc/arch-release ]] || die "This install script only supports Arch Linux."
}

require_sudo() {
  sudo -v
}

ensure_base_dirs() {
  mkdir -p \
    "${HOME}/.config" \
    "${HOME}/.config/wallpapers" \
    "${HOME}/.local/bin" \
    "${HOME}/Pictures/Screenshots"
}

install_pacman_packages() {
  local packages=("$@")
  if [[ "${#packages[@]}" -eq 0 ]]; then
    return 0
  fi

  info "Installing packages: ${packages[*]}"
  sudo pacman -S --needed "${packages[@]}"
}

backup_target() {
  local target="$1"

  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "${BACKUP_DIR}"
    mv "$target" "${BACKUP_DIR}/"
    info "Moved existing target to ${BACKUP_DIR}: ${target}"
  fi
}

link_dir() {
  local source_dir="$1"
  local target_dir="$2"

  mkdir -p "$(dirname "$target_dir")"
  backup_target "$target_dir"
  ln -s "$source_dir" "$target_dir"
  info "Linked ${target_dir} -> ${source_dir}"
}

link_file() {
  local source_file="$1"
  local target_file="$2"

  mkdir -p "$(dirname "$target_file")"
  backup_target "$target_file"
  ln -s "$source_file" "$target_file"
  info "Linked ${target_file} -> ${source_file}"
}

make_executable() {
  local file="$1"
  chmod +x "$file"
  info "Marked executable: ${file}"
}
