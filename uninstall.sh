#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

msg() {
    printf '\033[1;34m[INFO]\033[0m %s\n' "$*"
}

warn() {
    printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2
}

remove_if_repo_link() {
    local path="$1"
    local target

    [ -L "$path" ] || return 0

    target="$(readlink -f "$path" 2>/dev/null || true)"
    [ -n "$target" ] || return 0

    case "$target" in
        "$repo_root"/*)
            msg "Removing symlink: $path -> $target"
            rm -f -- "$path"
            ;;
    esac
}

scan_dir() {
    local dir="$1"
    [ -d "$dir" ] || return 0

    while IFS= read -r -d '' link; do
        remove_if_repo_link "$link"
    done < <(find "$dir" -type l -print0 2>/dev/null)
}

main() {
    msg "Repo root: $repo_root"

    # Common dotfile locations
    scan_dir "$HOME/.config"
    scan_dir "$HOME/.local/bin"
    scan_dir "$HOME/.local/share"
    scan_dir "$HOME/.oh-my-zsh/custom"
    scan_dir "$HOME"

    # Common top-level dotfiles
    remove_if_repo_link "$HOME/.bashrc"
    remove_if_repo_link "$HOME/.zshrc"
    remove_if_repo_link "$HOME/.zprofile"
    remove_if_repo_link "$HOME/.profile"
    remove_if_repo_link "$HOME/.gitconfig"
    remove_if_repo_link "$HOME/.gitignore_global"
    remove_if_repo_link "$HOME/.tmux.conf"
    remove_if_repo_link "$HOME/.vimrc"

    msg "Done."
}

main "$@"
