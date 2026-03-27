#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STOW_BUILD_DIR="${REPO_DIR}/.stow-build"
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
    "${HOME}/.config/Code - OSS/User" \
    "${HOME}/.config/dunst/dunstrc.d" \
    "${HOME}/.config/theme-switcher/current" \
    "${HOME}/.local/bin" \
    "${HOME}/.vscode-oss/extensions" \
    "${HOME}/Pictures/Screenshots"
}

install_pacman_packages() {
  local packages=("$@")
  (( ${#packages[@]} > 0 )) || return 0
  info "Installing packages: ${packages[*]}"
  sudo pacman -S --noconfirm --needed "${packages[@]}"
}

start_sudo_keepalive() {
  sudo -v
  (
    while true; do
      sudo -n true
      sleep 60
    done
  ) >/dev/null 2>&1 &
  SUDO_KEEPALIVE_PID=$!
  export SUDO_KEEPALIVE_PID
}

stop_sudo_keepalive() {
  if [[ -n "${SUDO_KEEPALIVE_PID:-}" ]]; then
    kill "${SUDO_KEEPALIVE_PID}" >/dev/null 2>&1 || true
  fi
}

mark_repo_binaries_executable() {
  local bin_dir="${REPO_DIR}/local-bin/bin"
  local file

  [[ -d "${bin_dir}" ]] || return 0

  while IFS= read -r -d '' file; do
    chmod +x "${file}"
  done < <(find "${bin_dir}" -maxdepth 1 -type f -print0)
}

prepare_stow_tree() {
  rm -rf "${STOW_BUILD_DIR}"
  mark_repo_binaries_executable
}

is_repo_managed_symlink() {
  local target="$1"
  local resolved=""

  [[ -L "${target}" ]] || return 1
  resolved="$(readlink -f "${target}" 2>/dev/null || true)"
  [[ -n "${resolved}" ]] || return 1

  case "${resolved}" in
    "${REPO_DIR}"|"${REPO_DIR}"/*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

backup_target_if_needed() {
  local target="$1"
  local rel backup_path

  [[ -e "${target}" || -L "${target}" ]] || return 0

  if is_repo_managed_symlink "${target}"; then
    return 0
  fi

  rel="${target#${HOME}/}"
  backup_path="${BACKUP_DIR}/${rel}"
  mkdir -p "$(dirname "${backup_path}")"
  mv "${target}" "${backup_path}"
  info "Backed up conflicting target: ${target} -> ${backup_path}"
}

backup_stow_targets() {
  local targets=(
    "${HOME}/.config/alacritty"
    "${HOME}/.config/dunst/dunstrc"
    "${HOME}/.config/emacs"
    "${HOME}/.config/fastfetch"
    "${HOME}/.config/hypr"
    "${HOME}/.config/nvim"
    "${HOME}/.config/rofi"
    "${HOME}/.config/theme-switcher/themes"
    "${HOME}/.config/waybar"
    "${HOME}/.config/Code - OSS/User"
    "${HOME}/.bashrc"
    "${HOME}/.zprofile"
    "${HOME}/.zshrc"
  )
  local file

  if [[ -d "${REPO_DIR}/local-bin/bin" ]]; then
    while IFS= read -r -d '' file; do
      targets+=("${HOME}/.local/bin/$(basename "${file}")")
    done < <(find "${REPO_DIR}/local-bin/bin" -maxdepth 1 -type f -print0 | sort -z)
  fi

  for target in "${targets[@]}"; do
    backup_target_if_needed "${target}"
  done
}

stow_group() {
  local action="$1"
  local target="$2"
  shift 2

  (( $# > 0 )) || return 0

  if [[ "${action}" == "restow" ]]; then
    info "Applying stow packages to ${target}: $*"
    stow --no-folding --restow --dir "${REPO_DIR}" --target "${target}" "$@"
  else
    info "Removing stow packages from ${target}: $*"
    stow --no-folding --delete --dir "${REPO_DIR}" --target "${target}" "$@" || true
  fi
}

stow_packages() {
  local config_packages=()
  local home_packages=()
  local local_packages=()

  for pkg in alacritty code-oss dunst emacs fastfetch hypr nvim rofi theme-switcher waybar; do
    [[ -d "${REPO_DIR}/${pkg}" ]] && config_packages+=("${pkg}")
  done

  for pkg in bash zsh; do
    [[ -d "${REPO_DIR}/${pkg}" ]] && home_packages+=("${pkg}")
  done

  [[ -d "${REPO_DIR}/local-bin" ]] && local_packages+=("local-bin")

  stow_group restow "${HOME}/.config" "${config_packages[@]}"
  stow_group restow "${HOME}" "${home_packages[@]}"
  stow_group restow "${HOME}/.local" "${local_packages[@]}"
}

unstow_packages() {
  local config_packages=()
  local home_packages=()
  local local_packages=()

  for pkg in alacritty code-oss dunst emacs fastfetch hypr nvim rofi theme-switcher waybar; do
    [[ -d "${REPO_DIR}/${pkg}" ]] && config_packages+=("${pkg}")
  done

  for pkg in bash zsh; do
    [[ -d "${REPO_DIR}/${pkg}" ]] && home_packages+=("${pkg}")
  done

  [[ -d "${REPO_DIR}/local-bin" ]] && local_packages+=("local-bin")

  stow_group delete "${HOME}/.config" "${config_packages[@]}"
  stow_group delete "${HOME}" "${home_packages[@]}"
  stow_group delete "${HOME}/.local" "${local_packages[@]}"
}
