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
alias vpn-uni='sudo openconnect -b vpn2x-tu-ilmenau.de'

# VPN Status prüfen
alias vpn-status='ip addr show tun0'

# VPN Beenden
alias vpn-off='sudo pkill -SIGINT openconnect'




alias cls="clear"
