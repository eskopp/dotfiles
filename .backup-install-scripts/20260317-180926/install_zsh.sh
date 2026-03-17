#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/common.sh"

clone_or_update() {
  local repo_url="$1"
  local target_dir="$2"

  if [[ -d "${target_dir}/.git" ]]; then
    info "Updating $(basename "${target_dir}")"
    git -C "${target_dir}" pull --ff-only
  else
    info "Cloning $(basename "${target_dir}")"
    rm -rf "${target_dir}"
    git clone --depth=1 "${repo_url}" "${target_dir}"
  fi
}

main() {
  local ohmyzsh_dir="${HOME}/.oh-my-zsh"
  local zsh_custom="${ohmyzsh_dir}/custom"
  local zsh_bin

  install_pacman_packages zsh git curl zoxide

  command -v zsh >/dev/null 2>&1 || die "zsh is not available after installation"
  command -v git >/dev/null 2>&1 || die "git is not available after installation"
  command -v curl >/dev/null 2>&1 || die "curl is not available after installation"

  if [[ ! -d "${ohmyzsh_dir}" ]]; then
    info "Installing Oh My Zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    info "Oh My Zsh already installed"
  fi

  [[ -d "${ohmyzsh_dir}" ]] || die "Oh My Zsh installation failed"

  mkdir -p "${zsh_custom}/plugins"

  clone_or_update \
    "https://github.com/marlonrichert/zsh-autocomplete" \
    "${zsh_custom}/plugins/zsh-autocomplete"

  zsh_bin="$(command -v zsh)"
  if [[ "${SHELL:-}" != "${zsh_bin}" ]]; then
    info "Setting Zsh as default shell"
    chsh -s "${zsh_bin}"
    info "Default shell changed to ${zsh_bin}. This applies on next login."
  else
    info "Zsh is already the current default shell"
  fi

  info "Zsh setup finished"
}

main "$@"
