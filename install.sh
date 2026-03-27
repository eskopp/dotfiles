#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${REPO_DIR}/scripts/common.sh"

install_required_packages() {
  install_pacman_packages \
    stow \
    qt5-wayland \
    qt6-wayland \
    qt5ct \
    qt6ct \
    wireplumber \
    firefox \
    fastfetch \
    jq \
    papirus-icon-theme \
    ttf-font-awesome \
    ttf-fira-sans \
    ttf-fira-code \
    ttf-firacode-nerd \
    hyprland \
    hyprpaper \
    hyprlock \
    hyprpolkitagent \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    waybar \
    alacritty \
    dunst \
    rofi \
    thunar \
    thunar-volman \
    tumbler \
    ffmpegthumbnailer \
    file-roller \
    wl-clipboard \
    cliphist \
    grim \
    slurp \
    swappy \
    brightnessctl \
    pavucontrol \
    wtype \
    libnotify \
    blueman \
    networkmanager \
    network-manager-applet \
    nm-connection-editor \
    zsh \
    git \
    curl \
    zoxide \
    code \
    neovim \
    emacs-wayland \
    python
}

install_code_oss_themes() {
  local themes_root="${REPO_DIR}/code-oss-theme"
  local dir target_dir

  [[ -d "${themes_root}" ]] || return 0

  mkdir -p "${HOME}/.vscode-oss/extensions"

  while IFS= read -r -d '' dir; do
    target_dir="${HOME}/.vscode-oss/extensions/$(basename "${dir}")"
    backup_target_if_needed "${target_dir}"
    ln -sfn "${dir}" "${target_dir}"
    info "Installed Code - OSS theme: $(basename "${dir}")"
  done < <(find "${themes_root}" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
}

main() {
  require_arch
  require_sudo
  start_sudo_keepalive
  trap stop_sudo_keepalive EXIT

  ensure_base_dirs
  install_required_packages

  bash "${REPO_DIR}/scripts/install_zsh.sh"

  prepare_stow_tree
  backup_stow_targets
  stow_packages

  install_code_oss_themes

  info "Enabling NetworkManager"
  sudo systemctl enable --now NetworkManager
  sudo systemctl disable --now iwd 2>/dev/null || true

  if [[ -x "${HOME}/.local/bin/theme-apply" ]]; then
    info "Applying default theme: nord"
    "${HOME}/.local/bin/theme-apply" nord
  else
    warn "theme-apply was not found after stowing; skipping default theme application"
  fi

  info "All installers finished successfully."
  printf '\n'
  printf 'Next steps:\n'
  printf '  1. Put wallpapers into: %s\n' "${HOME}/git/wallpaper"
  printf '  2. Start Hyprland from a TTY with:\n'
  printf '     %s\n' "${HOME}/.local/bin/start-hyprland"
  printf '  3. Check Fastfetch with:\n'
  printf '     fastfetch\n'
}

main "$@"
