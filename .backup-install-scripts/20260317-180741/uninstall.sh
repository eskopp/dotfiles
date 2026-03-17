#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if repo_root="$(git -C "${script_dir}" rev-parse --show-toplevel 2>/dev/null)"; then
    :
else
    repo_root="${script_dir}"
fi

msg() {
    printf '\033[1;34m[INFO]\033[0m %s\n' "$*"
}

warn() {
    printf '\033[1;33m[WARN]\033[0m %s\n' "$*" >&2
}

remove_if_repo_link() {
    local path="$1"
    local link_target
    local candidate_target
    local resolved_target

    [[ -L "$path" ]] || return 0

    link_target="$(readlink "$path" 2>/dev/null || true)"
    [[ -n "$link_target" ]] || return 0

    if [[ "$link_target" = /* ]]; then
        candidate_target="$link_target"
    else
        candidate_target="$(dirname "$path")/${link_target}"
    fi

    resolved_target="$(realpath -m "$candidate_target" 2>/dev/null || true)"
    [[ -n "$resolved_target" ]] || return 0

    case "$resolved_target" in
        "$repo_root"|"$repo_root"/*)
            msg "Removing symlink: $path -> $resolved_target"
            rm -f -- "$path"
            ;;
    esac
}

scan_dir_for_repo_links() {
    local dir="$1"
    [[ -d "$dir" ]] || return 0

    while IFS= read -r -d '' link; do
        remove_if_repo_link "$link"
    done < <(find "$dir" -type l -print0 2>/dev/null)
}

remove_known_top_level_links() {
    local paths=(
        "$HOME/.bashrc"
        "$HOME/.zshrc"
        "$HOME/.zprofile"
        "$HOME/.profile"
        "$HOME/.gitconfig"
        "$HOME/.gitignore_global"
        "$HOME/.tmux.conf"
        "$HOME/.vimrc"
    )

    local path
    for path in "${paths[@]}"; do
        remove_if_repo_link "$path"
    done
}

remove_stale_generated_files() {
    local candidates=(
        "$HOME/.config/hypr/conf.d/screenshots.conf"
        "$HOME/.local/bin/net-speed"
        "$HOME/.local/bin/polarshot"
        "$HOME/.local/bin/random-wallpaper"
        "$HOME/.local/bin/hyprpaper-start"
        "$HOME/.local/bin/screenshot-region"
        "$HOME/.local/bin/start-hyprland"
        "$HOME/.local/bin/bluetooth-menu"
        "$HOME/.local/bin/clipboard-daemon"
        "$HOME/.local/bin/clipboard-menu"
        "$HOME/.local/bin/power-menu"
        "$HOME/.local/bin/wifi-menu"
    )

    local path
    for path in "${candidates[@]}"; do
        remove_if_repo_link "$path"
    done
}

remove_screenshot_include_line() {
    local hyprland_conf="${HOME}/.config/hypr/hyprland.conf"

    [[ -f "$hyprland_conf" ]] || return 0
    [[ ! -L "$hyprland_conf" ]] || return 0

    if grep -qE '^[[:space:]]*source = (\$HOME|~)/\.config/hypr/conf\.d/screenshots\.conf[[:space:]]*$' "$hyprland_conf"; then
        msg "Removing screenshots include from ${hyprland_conf}"
        sed -i -E '/^[[:space:]]*source = (\$HOME|~)\/\.config\/hypr\/conf\.d\/screenshots\.conf[[:space:]]*$/d' "$hyprland_conf"
    fi
}

remove_empty_dirs() {
    local dirs=(
        "$HOME/.config/hypr/conf.d"
        "$HOME/.config/hypr"
        "$HOME/.config/waybar"
        "$HOME/.config/dunst"
        "$HOME/.config/rofi"
        "$HOME/.config/alacritty"
        "$HOME/.local/bin"
        "$HOME/.local/share"
        "$HOME/.oh-my-zsh/custom"
    )

    local dir
    for dir in "${dirs[@]}"; do
        while [[ "$dir" != "$HOME" && "$dir" != "/" ]]; do
            if [[ -d "$dir" ]] && [[ -z "$(ls -A "$dir" 2>/dev/null)" ]]; then
                msg "Removing empty directory: $dir"
                rmdir "$dir" 2>/dev/null || true
                dir="$(dirname "$dir")"
            else
                break
            fi
        done
    done
}

main() {
    msg "Repo root: $repo_root"
    warn "This removes repo-managed symlinks and cleanup artifacts."
    warn "It does not restore original files unless you created backups separately."

    scan_dir_for_repo_links "$HOME/.config"
    scan_dir_for_repo_links "$HOME/.local/bin"
    scan_dir_for_repo_links "$HOME/.local/share"
    scan_dir_for_repo_links "$HOME/.oh-my-zsh/custom"

    remove_known_top_level_links
    remove_stale_generated_files
    remove_screenshot_include_line
    remove_empty_dirs

    msg "Done."
}

main "$@"
