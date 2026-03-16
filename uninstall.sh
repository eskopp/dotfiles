#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(git -C "${script_dir}" rev-parse --show-toplevel 2>/dev/null || printf '%s' "${script_dir}")"

msg() {
    printf '\033[1;34m[INFO]\033[0m %s\n' "$*"
}

warn() {
    printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2
}

remove_if_repo_link() {
    local path="$1"
    local link_target
    local resolved_target
    local candidate_target

    [ -L "$path" ] || return 0

    link_target="$(readlink "$path" 2>/dev/null || true)"
    [ -n "$link_target" ] || return 0

    if [[ "$link_target" = /* ]]; then
        candidate_target="$link_target"
    else
        candidate_target="$(dirname "$path")/${link_target}"
    fi

    resolved_target="$(realpath -m "$candidate_target" 2>/dev/null || true)"
    [ -n "$resolved_target" ] || return 0

    case "$resolved_target" in
        "$repo_root"/*)
            msg "Removing symlink: $path -> $resolved_target"
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

remove_screenshot_include_line() {
    local hyprland_conf="${HOME}/.config/hypr/hyprland.conf"
    local include_line='source = $HOME/.config/hypr/conf.d/screenshots.conf'
    local legacy_include_line='source = ~/.config/hypr/conf.d/screenshots.conf'

    [[ -f "$hyprland_conf" ]] || return 0

    if grep -qxF "$include_line" "$hyprland_conf"; then
        msg "Removing screenshots include from ${hyprland_conf}"
        sed -i "\|^${include_line}$|d" "$hyprland_conf"
    fi

    if grep -qxF "$legacy_include_line" "$hyprland_conf"; then
        msg "Removing legacy screenshots include from ${hyprland_conf}"
        sed -i "\|^${legacy_include_line}$|d" "$hyprland_conf"
    fi
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

    remove_screenshot_include_line

    msg "Done."
}

main "$@"
