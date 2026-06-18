# ~/.zprofile
if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" && "$XDG_VTNR" == "1" ]]; then
    exec uwsm start hyprland.desktop
fi

# XDG base directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Default applications
export EDITOR="nano"
export VISUAL="nano"
export BROWSER="firefox"
export TERMINAL="foot"

# User paths
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
