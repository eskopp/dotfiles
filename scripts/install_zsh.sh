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

ensure_repo_file() {
	local home_file="$1"
	local repo_file="$2"
	local file_type="$3"

	if [[ -f "${repo_file}" ]]; then
		info "Repo ${file_type} already exists: ${repo_file}"
		return
	fi

	if [[ -f "${home_file}" && ! -L "${home_file}" ]]; then
		info "Adopting existing ${home_file} into repo"
		cp "${home_file}" "${repo_file}"
		return
	fi

	info "Creating default ${file_type} in repo: ${repo_file}"

	if [[ "${file_type}" == ".zshrc" ]]; then
		cat > "${repo_file}" <<'EORC'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
	git
	python
	docker
	zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh
EORC
	elif [[ "${file_type}" == ".zprofile" ]]; then
		cat > "${repo_file}" <<'EOPF'
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/pipx/bin:$PATH"
EOPF
	else
		die "Unknown file type: ${file_type}"
	fi
}

main() {
	local ohmyzsh_dir="${HOME}/.oh-my-zsh"
	local zsh_custom="${ohmyzsh_dir}/custom"
	local repo_zsh_dir="${REPO_ROOT}/zsh"
	local repo_zshrc="${repo_zsh_dir}/.zshrc"
	local repo_zprofile="${repo_zsh_dir}/.zprofile"
	local target_zshrc="${HOME}/.zshrc"
	local target_zprofile="${HOME}/.zprofile"
	local zsh_bin

	info "Installing Zsh and Oh My Zsh"

	ensure_pkg zsh
	ensure_pkg git
	ensure_pkg curl
        ensure_pkg zoxide

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
	mkdir -p "${repo_zsh_dir}"

	clone_or_update \
		"https://github.com/marlonrichert/zsh-autocomplete" \
		"${zsh_custom}/plugins/zsh-autocomplete"

	ensure_repo_file "${target_zshrc}" "${repo_zshrc}" ".zshrc"
	ensure_repo_file "${target_zprofile}" "${repo_zprofile}" ".zprofile"

	backup_if_regular_file "${target_zshrc}"
	backup_if_regular_file "${target_zprofile}"

	info "Linking ${target_zshrc} -> ${repo_zshrc}"
	ln -sfn "${repo_zshrc}" "${target_zshrc}"

	info "Linking ${target_zprofile} -> ${repo_zprofile}"
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
	info "Verify with:"
	info "  ls -l ~/.zshrc ~/.zprofile"
	info "  readlink -f ~/.zshrc"
	info "  readlink -f ~/.zprofile"
}

main "$@"
