# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


alias cls="clear"

# Add user-local binaries (e.g. pip --user installs)
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

[[ -r "$HOME/.config/shell/dev-env.sh" ]] && source "$HOME/.config/shell/dev-env.sh"
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# WLAN-Netze im Umkreis mit Signalstärke, Kanal, Frequenz, Verschlüsselung
wlanstats() {
    local iface
    iface="${1:-$(nmcli -t -f DEVICE,TYPE device status 2>/dev/null | awk -F: '$2=="wifi"{print $1; exit}')}"
    if [ -z "$iface" ]; then
        echo "Kein WLAN-Interface gefunden." >&2
        return 1
    fi
    echo "Scanne auf $iface ..." >&2
    {
        printf 'SIGNAL\tSSID\tBARS\tCHAN\tFREQ\tSECURITY\tBSSID\n'
        nmcli -t -m multiline -f SSID,SIGNAL,BARS,CHAN,FREQ,SECURITY,BSSID device wifi list ifname "$iface" --rescan yes \
        | awk '
            {
                c = index($0, ":")
                key = substr($0, 1, c - 1)
                val = substr($0, c + 1)
                if (key == "SSID")          ssid = (val == "" ? "(versteckt)" : val)
                else if (key == "SIGNAL")   sig = val
                else if (key == "BARS")     bars = val
                else if (key == "CHAN")     chan = val
                else if (key == "FREQ")     freq = val
                else if (key == "SECURITY") sec = (val == "" ? "offen" : val)
                else if (key == "BSSID") {
                    printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n", sig, ssid, bars, chan, freq, sec, val
                }
            }' \
        | sort -t$'\t' -k1,1 -rn
    } | column -t -s $'\t'
}
alias wlanstat=wlanstats
