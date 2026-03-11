#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

if [[ -f "${SCRIPT_DIR}/common.sh" ]]; then
	# shellcheck source=/dev/null
	source "${SCRIPT_DIR}/common.sh"
fi

if ! declare -F info >/dev/null 2>&1; then
	info() {
		printf '[INFO] %s\n' "$*"
	}
fi

if ! declare -F warn >/dev/null 2>&1; then
	warn() {
		printf '[WARN] %s\n' "$*" >&2
	}
fi

if ! declare -F die >/dev/null 2>&1; then
	die() {
		printf '[ERROR] %s\n' "$*" >&2
		exit 1
	}
fi

ensure_pkg() {
	local pkg="$1"

	if declare -F ensure_package >/dev/null 2>&1; then
		ensure_package "${pkg}"
		return
	fi

	if pacman -Q "${pkg}" >/dev/null 2>&1; then
		info "Package already installed: ${pkg}"
	else
		info "Installing package: ${pkg}"
		sudo pacman -S --noconfirm --needed "${pkg}"
	fi
}

backup_if_regular_file() {
	local target="$1"

	if [[ -L "${target}" ]]; then
		return
	fi

	if [[ -e "${target}" ]]; then
		local backup="${target}.bak.$(date +%Y%m%d-%H%M%S)"
		info "Backing up ${target} to ${backup}"
		mv "${target}" "${backup}"
	fi
}

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
	local repo_zshrc="${REPO_ROOT}/zsh/.zshrc"
	local repo_zprofile="${REPO_ROOT}/zsh/.zprofile"
	local target_zshrc="${HOME}/.zshrc"
	local target_zprofile="${HOME}/.zprofile"
	local zsh_bin

	info "Installing Zsh and Oh My Zsh"

	ensure_pkg zsh
	ensure_pkg git
	ensure_pkg curl

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

	[[ -f "${repo_zshrc}" ]] || die "Missing repo file: ${repo_zshrc}"
	[[ -f "${repo_zprofile}" ]] || die "Missing repo file: ${repo_zprofile}"

	backup_if_regular_file "${target_zshrc}"
	backup_if_regular_file "${target_zprofile}"

	info "Linking .zshrc"
	ln -sfn "${repo_zshrc}" "${target_zshrc}"

	info "Linking .zprofile"
	ln -sfn "${repo_zprofile}" "${target_zprofile}"

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
