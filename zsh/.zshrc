export ZSH="$HOME/.oh-my-zsh"

source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

ZSH_THEME="frisk"
plugins=()

source $ZSH/oh-my-zsh.sh

alias cls="clear"

# VPN
alias vpn-on='sudo openconnect -b vpn2x.tu-ilmenau.de'
alias vpn-status='ip addr show tun0'
alias vpn-off='sudo pkill -SIGINT openconnect'

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

alias fixscreen='hyprctl dispatch dpms off eDP-1 && sleep 1 && hyprctl dispatch dpms on eDP-1'

export PATH="$HOME/.cargo/bin:$PATH"


if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi
