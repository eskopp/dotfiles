# ~/.zshrc

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="frisk"
plugins=()

source "$ZSH/oh-my-zsh.sh"

# Completion behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes false

# History
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# Aliases
alias cls="clear"
alias neofetch="fastfetch"
alias yay-update="yay -Syu --noconfirm && yay -Sc --noconfirm"
alias paru-update="paru -Syu && paru -Sc --noconfirm"
alias pacman-update="sudo pacman -Syyu"


# NeoVim
alias neovim="nvim"
alias vim="nvim"

# Funny Stuff
alias please="sudo"

# VPN
alias vpn-on='sudo openconnect --protocol=anyconnect --authgroup="mfa-full+IPv6" -b vpn2x.tu-ilmenau.de'
alias vpn-status='ip addr show tun0 2>/dev/null || echo "tun0 is not up."'
alias vpn-off='sudo pkill -SIGINT openconnect'

# Display / screen helpers
alias fixscreen='hyprctl dispatch dpms off eDP-1 && sleep 1 && hyprctl dispatch dpms on eDP-1'

# IPv6 toggle
ipv6_off() {
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
    sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
    echo "IPv6 wurde deaktiviert."
}

ipv6_on() {
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0
    sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=0
    echo "IPv6 wurde aktiviert."
}

# zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi


# zsh-autocomplete (async off prevents /proc/self/fd exhaustion in long sessions)
zstyle ':autocomplete:*' async off
zstyle ':autocomplete:*' delay 0.1
if [ -r "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]; then
    source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
elif [ -r /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

# zsh-autosuggestions
if [ -r "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
unset ZSH_AUTOSUGGEST_USE_ASYNC

# Optional syntax highlighting
if [ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
 

# ── Frostfire-Nord Colors ─────────────────────────────────────────────────────
# directories=orange  symlinks=bright-blue  executables=green
# archives=purple     images=yellow         audio/video=cyan
export LS_COLORS="\
di=38;2;246;157;80;1:\
ln=38;2;130;170;255:\
ex=38;2;163;190;140;1:\
fi=38;2;216;222;233:\
pi=38;2;235;203;139:\
so=38;2;180;142;173:\
bd=38;2;191;97;106;1:\
cd=38;2;191;97;106:\
or=38;2;191;97;106;1;4:\
mi=38;2;76;86;106:\
ow=38;2;246;157;80:\
tw=38;2;246;157;80;4:\
st=38;2;136;192;208;1:\
*.tar=38;2;180;142;173:*.tgz=38;2;180;142;173:*.zip=38;2;180;142;173:\
*.gz=38;2;180;142;173:*.bz2=38;2;180;142;173:*.xz=38;2;180;142;173:\
*.7z=38;2;180;142;173:*.rar=38;2;180;142;173:*.zst=38;2;180;142;173:\
*.jpg=38;2;235;203;139:*.jpeg=38;2;235;203;139:*.png=38;2;235;203;139:\
*.gif=38;2;235;203;139:*.svg=38;2;235;203;139:*.webp=38;2;235;203;139:\
*.ico=38;2;235;203;139:*.bmp=38;2;235;203;139:\
*.mp4=38;2;180;142;173:*.mkv=38;2;180;142;173:*.webm=38;2;180;142;173:\
*.avi=38;2;180;142;173:*.mov=38;2;180;142;173:\
*.mp3=38;2;136;192;208:*.flac=38;2;136;192;208:*.wav=38;2;136;192;208:\
*.ogg=38;2;136;192;208:*.m4a=38;2;136;192;208:\
*.pdf=38;2;130;170;255:*.md=38;2;130;170;255:\
*.toml=38;2;235;203;139:*.json=38;2;235;203;139:\
*.yaml=38;2;235;203;139:*.yml=38;2;235;203;139:\
*.py=38;2;163;190;140:*.js=38;2;163;190;140:*.ts=38;2;163;190;140:\
*.sh=38;2;163;190;140:*.bash=38;2;163;190;140:*.zsh=38;2;163;190;140:\
*.rs=38;2;163;190;140:*.go=38;2;163;190;140:*.c=38;2;163;190;140:\
*.cpp=38;2;163;190;140:*.h=38;2;130;170;255"

alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lah --color=auto'

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:*:*:descriptions' format '%F{#F69D50}%d%f'
zstyle ':completion:*:messages'           format '%F{#82AAFF}%d%f'
zstyle ':completion:*:warnings'           format '%F{#BF616A}Nichts gefunden: %d%f'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4C566A"

alias code='code --no-sandbox'

[[ -r "$HOME/.config/shell/dev-env.sh" ]] && source "$HOME/.config/shell/dev-env.sh"

alias vpn-tu='sudo openconnect --protocol=anyconnect --authgroup="mfa-full" --user="josk9243" --no-external-auth --no-xmlpost --no-dtls --script /etc/vpnc/vpnc-script vpn2x.tu-ilmenau.de'
alias vpn-off='sudo pkill -SIGINT openconnect'
alias vpn-status='ip addr show tun0 2>/dev/null || echo "tun0 ist nicht aktiv"; ip route get 141.24.1.1 2>/dev/null || true'
