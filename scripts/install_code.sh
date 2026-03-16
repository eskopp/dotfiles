#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

main() {
  local code_home="${HOME}/.config/Code - OSS/User"
  local repo_code_home="${REPO_DIR}/config/code-oss/User"

  install_pacman_packages code

  mkdir -p "${code_home}" "${repo_code_home}" "${repo_code_home}/snippets"

  [[ -f "${repo_code_home}/settings.json" ]] || printf '{}\n' > "${repo_code_home}/settings.json"
  [[ -f "${repo_code_home}/keybindings.json" ]] || printf '[]\n' > "${repo_code_home}/keybindings.json"

  link_file "${repo_code_home}/settings.json" "${code_home}/settings.json"
  link_file "${repo_code_home}/keybindings.json" "${code_home}/keybindings.json"
  link_dir "${repo_code_home}/snippets" "${code_home}/snippets"
}

main "$@"
