#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:-${DOTFILES_REPO_URL:-}}"
REF="${DOTFILES_REF:-main}"

if [[ -z "${REPO_URL}" ]]; then
  cat >&2 <<'MSG'
[bootstrap] Missing repository URL.

Usage:
  bash bootstrap.sh <repo-url>

Example:
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/<user>/<repo>/main/bootstrap.sh)" -- \
    https://github.com/<user>/<repo>.git

Optional environment variables:
  DOTFILES_REF=<branch-or-tag>   (default: main)
MSG
  exit 1
fi

WORKDIR="$(mktemp -d -t dotfiles-bootstrap-XXXXXX)"
cleanup() {
  rm -rf "${WORKDIR}"
}
trap cleanup EXIT

command -v git >/dev/null 2>&1 || {
  echo "[bootstrap] git is required but not installed." >&2
  exit 1
}

command -v bash >/dev/null 2>&1 || {
  echo "[bootstrap] bash is required but not installed." >&2
  exit 1
}

echo "[bootstrap] Cloning ${REPO_URL} (${REF}) ..."
git clone --depth 1 --branch "${REF}" "${REPO_URL}" "${WORKDIR}/dotfiles"

echo "[bootstrap] Running install.sh ..."
exec bash "${WORKDIR}/dotfiles/install.sh"
