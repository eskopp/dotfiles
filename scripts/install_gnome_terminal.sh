#!/usr/bin/env bash
set -euo pipefail

if ! command -v gnome-terminal &>/dev/null; then
  echo "[gnome-terminal] gnome-terminal not installed, skipping."
  exit 0
fi

if ! command -v dconf &>/dev/null; then
  echo "[gnome-terminal] dconf not found, cannot apply profile."
  exit 1
fi

echo "[gnome-terminal] Applying Nord profile via dconf..."

UUID="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
BASE="/org/gnome/terminal/legacy/profiles:/:${UUID}"

dconf write /org/gnome/terminal/legacy/profiles:/list   "['${UUID}']"
dconf write /org/gnome/terminal/legacy/profiles:/default "'${UUID}'"
dconf write /org/gnome/terminal/legacy/default-size-columns 120
dconf write /org/gnome/terminal/legacy/default-size-rows    32
dconf write /org/gnome/terminal/legacy/theme-variant        "'dark'"

dconf write "${BASE}/visible-name"                "'Frostfire Nord'"
dconf write "${BASE}/use-system-font"             "false"
dconf write "${BASE}/font"                        "'FiraCode Nerd Font Mono 11'"
dconf write "${BASE}/use-theme-colors"            "false"
dconf write "${BASE}/background-color"            "'#2E3440'"
dconf write "${BASE}/foreground-color"            "'#D8DEE9'"
dconf write "${BASE}/bold-color"                  "'#D8DEE9'"
dconf write "${BASE}/bold-color-same-as-fg"       "true"
dconf write "${BASE}/bold-is-bright"              "false"
dconf write "${BASE}/use-transparent-background"  "true"
dconf write "${BASE}/background-transparency-percent" "20"
dconf write "${BASE}/scrollback-unlimited"        "false"
dconf write "${BASE}/scrollback-lines"            "10000"
dconf write "${BASE}/cursor-shape"               "'block'"
dconf write "${BASE}/cursor-blink-mode"          "'off'"
dconf write "${BASE}/default-show-menubar"       "false"
dconf write "${BASE}/palette" \
  "['#3B4252','#BF616A','#A3BE8C','#D08770','#5E81AC','#B48EAD','#88C0D0','#E5E9F0','#4C566A','#BF616A','#A3BE8C','#EBCB8B','#81A1C1','#B48EAD','#8FBCBB','#ECEFF4']"

echo "[gnome-terminal] Done."
