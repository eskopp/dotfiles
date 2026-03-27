#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:-${DOTFILES_REPO_URL:-}}"
REF="${DOTFILES_REF:-main}"
INSTALL_DIR="${DOTFILES_INSTALL_DIR:-$HOME/git/dotfiles}"

if [[ -z "${REPO_URL}" ]]; then
  cat >&2 <<'MSG'
[bootstrap] Missing repository URL.

Usage:
  bash bootstrap.sh <repo-url>

Example:
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/<user>/<repo>/main/bootstrap.sh)" -- \
    https://github.com/\<user\>/\<repo\>.git

Optional environment variables:
  DOTFILES_REF=<branch-or-tag>     (default: main)
  DOTFILES_INSTALL_DIR=<path>      (default: ~/git/dotfiles)
MSG
  exit 1
fi

command -v git >/dev/null 2>&1 || {
  echo "[bootstrap] git is required but not installed." >&2
  exit 1
}

command -v bash >/dev/null 2>&1 || {
  echo "[bootstrap] bash is required but not installed." >&2
  exit 1
}

mkdir -p "$(dirname "${INSTALL_DIR}")"

if [[ -d "${INSTALL_DIR}/.git" ]]; then
  echo "[bootstrap] Updating existing repo in ${INSTALL_DIR} ..."
  git -C "${INSTALL_DIR}" fetch --depth 1 origin "${REF}"
  git -C "${INSTALL_DIR}" checkout -f FETCH_HEAD
else
  if [[ -e "${INSTALL_DIR}" ]]; then
    echo "[bootstrap] Refusing to overwrite existing path: ${INSTALL_DIR}" >&2
    exit 1
  fi

  echo "[bootstrap] Cloning ${REPO_URL} (${REF}) into ${INSTALL_DIR} ..."
  git clone --depth 1 --branch "${REF}" "${REPO_URL}" "${INSTALL_DIR}"
fi

echo "[bootstrap] Running install.sh from ${INSTALL_DIR} ..."
exec bash "${INSTALL_DIR}/install.sh"
