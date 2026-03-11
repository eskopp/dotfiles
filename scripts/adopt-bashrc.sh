#!/usr/bin/env bash
set -euo pipefail

msg() {
  printf '\033[1;34m[INFO]\033[0m %s\n' "$*"
}

warn() {
  printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2
}

die() {
  printf '\033[1;31m[ERROR]\033[0m %s\n' "$*" >&2
  exit 1
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

require_cmd git
require_cmd ln
require_cmd cp
require_cmd mkdir
require_cmd date
require_cmd readlink

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
[[ -n "${REPO_ROOT}" ]] || die "Current directory is not inside a git repository."

HOME_BASHRC="${HOME}/.bashrc"
REPO_BASH_DIR="${REPO_ROOT}/bash"
REPO_BASHRC="${REPO_BASH_DIR}/.bashrc"
BACKUP_DIR="${HOME}/.config/dotfiles-backups"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
COMMIT_MESSAGE="${1:-add bashrc to dotfiles}"

mkdir -p "${REPO_BASH_DIR}"
mkdir -p "${BACKUP_DIR}"

backup_home_bashrc() {
  if [[ -e "${HOME_BASHRC}" || -L "${HOME_BASHRC}" ]]; then
    local backup_path="${BACKUP_DIR}/.bashrc.bak.${TIMESTAMP}"
    cp -a "${HOME_BASHRC}" "${backup_path}"
    msg "Backup created: ${backup_path}"
  fi
}

copy_current_bashrc_into_repo() {
  if [[ -f "${REPO_BASHRC}" ]]; then
    msg "Repo file already exists: ${REPO_BASHRC}"
    return
  fi

  if [[ -L "${HOME_BASHRC}" ]]; then
    local resolved
    resolved="$(readlink -f "${HOME_BASHRC}")"
    [[ -n "${resolved}" && -f "${resolved}" ]] || die "~/.bashrc is a broken symlink."
    cp -a "${resolved}" "${REPO_BASHRC}"
    msg "Copied symlink target into repo: ${resolved} -> ${REPO_BASHRC}"
    return
  fi

  if [[ -f "${HOME_BASHRC}" ]]; then
    cp -a "${HOME_BASHRC}" "${REPO_BASHRC}"
    msg "Copied ${HOME_BASHRC} -> ${REPO_BASHRC}"
    return
  fi

  warn "No existing ~/.bashrc found. Creating a new empty repo file."
  : > "${REPO_BASHRC}"
}

link_home_bashrc() {
  ln -sfn "${REPO_BASHRC}" "${HOME_BASHRC}"
  msg "Linked ${HOME_BASHRC} -> ${REPO_BASHRC}"
}

commit_changes() {
  git -C "${REPO_ROOT}" add "bash/.bashrc"

  if git -C "${REPO_ROOT}" diff --cached --quiet; then
    warn "No staged changes detected. Nothing to commit."
    return
  fi

  git -C "${REPO_ROOT}" commit -m "${COMMIT_MESSAGE}"
  msg "Commit created: ${COMMIT_MESSAGE}"
}

main() {
  msg "Repository root: ${REPO_ROOT}"
  backup_home_bashrc
  copy_current_bashrc_into_repo
  link_home_bashrc
  commit_changes

  printf '\n'
  msg "Done."
  msg "Repo file: ${REPO_BASHRC}"
  msg "Home link: ${HOME_BASHRC}"
}

main "$@"
