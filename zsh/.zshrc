export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="frisk"

plugins=(
	git
	python
	docker
	zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh


# VPN Starten (läuft im Hintergrund, fragt einmal nach sudo & Passwort)
alias vpn-on='sudo openconnect -b vpn2x.tu-ilmenau.de'

# VPN Status prüfen
alias vpn-status='ip addr show tun0'

# VPN Beenden
alias vpn-off='sudo pkill -SIGINT openconnect'


# IPv6 Toggle Funktionen
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

alias cls="clear"
