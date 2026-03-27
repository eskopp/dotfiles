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
    "${HOME}/.config/theme-switcher/current" \
    "${HOME}/.local/bin" \
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

link_into_package() {
  local package="$1"
  local relpath="$2"
  local source_path="$3"

  mkdir -p "${STOW_BUILD_DIR}/${package}/$(dirname "${relpath}")"
  ln -sfn "${source_path}" "${STOW_BUILD_DIR}/${package}/${relpath}"
}

link_home_dotfiles_from_dir() {
  local package="$1"
  local source_dir="$2"
  local file base

  [[ -d "${source_dir}" ]] || return 0

  while IFS= read -r -d '' file; do
    base="$(basename "${file}")"
    link_into_package "${package}" "${base}" "${file}"
  done < <(find "${source_dir}" -maxdepth 1 -mindepth 1 -type f -name '.*' -print0 | sort -z)
}

prepare_stow_tree() {
  local file base

  rm -rf "${STOW_BUILD_DIR}"
  mkdir -p "${STOW_BUILD_DIR}"

  mark_repo_binaries_executable

  [[ -d "${REPO_DIR}/alacritty/alacritty" ]] \
    && link_into_package alacritty ".config/alacritty" "${REPO_DIR}/alacritty/alacritty"

  [[ -d "${REPO_DIR}/dunst/dunst" ]] \
    && link_into_package dunst ".config/dunst" "${REPO_DIR}/dunst/dunst"

  [[ -d "${REPO_DIR}/emacs/emacs" ]] \
    && link_into_package emacs ".config/emacs" "${REPO_DIR}/emacs/emacs"

  [[ -d "${REPO_DIR}/fastfetch/fastfetch" ]] \
    && link_into_package fastfetch ".config/fastfetch" "${REPO_DIR}/fastfetch/fastfetch"

  [[ -d "${REPO_DIR}/hypr/hypr" ]] \
    && link_into_package hypr ".config/hypr" "${REPO_DIR}/hypr/hypr"

  [[ -d "${REPO_DIR}/nvim/nvim" ]] \
    && link_into_package nvim ".config/nvim" "${REPO_DIR}/nvim/nvim"

  [[ -d "${REPO_DIR}/rofi/rofi" ]] \
    && link_into_package rofi ".config/rofi" "${REPO_DIR}/rofi/rofi"

  [[ -d "${REPO_DIR}/waybar/waybar" ]] \
    && link_into_package waybar ".config/waybar" "${REPO_DIR}/waybar/waybar"

  [[ -d "${REPO_DIR}/code-oss/Code - OSS/User" ]] \
    && link_into_package code-oss ".config/Code - OSS/User" "${REPO_DIR}/code-oss/Code - OSS/User"

  [[ -d "${REPO_DIR}/theme-switcher/theme-switcher/themes" ]] \
    && link_into_package theme-switcher ".config/theme-switcher/themes" "${REPO_DIR}/theme-switcher/theme-switcher/themes"

  link_home_dotfiles_from_dir bash "${REPO_DIR}/bash"
  link_home_dotfiles_from_dir zsh "${REPO_DIR}/zsh"

  if [[ -d "${REPO_DIR}/local-bin/bin" ]]; then
    while IFS= read -r -d '' file; do
      base="$(basename "${file}")"
      link_into_package local-bin ".local/bin/${base}" "${file}"
    done < <(find "${REPO_DIR}/local-bin/bin" -maxdepth 1 -type f -print0 | sort -z)
  fi
}

is_repo_managed_symlink() {
  local target="$1"
  local resolved=""

  [[ -L "${target}" ]] || return 1
  resolved="$(readlink -f "${target}" 2>/dev/null || true)"
  [[ -n "${resolved}" ]] || return 1

  case "${resolved}" in
    "${REPO_DIR}"|"${REPO_DIR}"/*|"${STOW_BUILD_DIR}"|"${STOW_BUILD_DIR}"/*)
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
    "${HOME}/.config/dunst"
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

collect_stow_packages() {
  local packages=()
  local dir

  [[ -d "${STOW_BUILD_DIR}" ]] || return 0

  while IFS= read -r -d '' dir; do
    packages+=("$(basename "${dir}")")
  done < <(find "${STOW_BUILD_DIR}" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

  printf '%s\n' "${packages[@]}"
}

stow_packages() {
  mapfile -t packages < <(collect_stow_packages)
  (( ${#packages[@]} > 0 )) || {
    warn "No stow packages found in ${STOW_BUILD_DIR}"
    return 0
  }

  info "Applying stow packages: ${packages[*]}"
  stow --no-folding --restow --dir "${STOW_BUILD_DIR}" --target "${HOME}" "${packages[@]}"
}

unstow_packages() {
  mapfile -t packages < <(collect_stow_packages)
  (( ${#packages[@]} > 0 )) || return 0

  info "Removing stow packages: ${packages[*]}"
  stow --no-folding --delete --dir "${STOW_BUILD_DIR}" --target "${HOME}" "${packages[@]}" || true
}
