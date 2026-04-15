# Waybar

This directory contains the Waybar configuration for this dotfiles repository.

## Files

The Waybar setup consists of:

- `waybar/waybar/config.jsonc`
- `waybar/waybar/style.css`
- `waybar/waybar/README.md`

When installed through GNU Stow, these files end up at:

- `~/.config/waybar/config.jsonc`
- `~/.config/waybar/style.css`
- `~/.config/waybar/README.md`

## Installation

Waybar is installed by the repository install script.

Run:

```sh
./install.sh
```

You can also restow only Waybar manually:

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" waybar
```

## Reloading Waybar

Restart Waybar with:

```sh
pkill waybar && waybar >/dev/null 2>&1 &
```

## Layout

### Left side

- Hyprland workspaces

### Center

- clock

### Right side

- idle inhibitor
- pulseaudio
- bluetooth
- network
- custom net speed
- cpu
- temperature
- battery
- tray
- power button

## Custom scripts used by Waybar

This setup depends on:

- `local-bin/bin/net-speed`
- `local-bin/bin/power-menu`
- `local-bin/bin/bluetooth-menu`

## File structure in the repo

```text
waybar/
└── waybar
    ├── config.jsonc
    ├── style.css
    └── README.md
```

## Troubleshooting

### Waybar does not start

```sh
waybar
```

### Styling changes do not appear

```sh
pkill waybar && waybar >/dev/null 2>&1 &
```

### Check installed files

```sh
ls -l ~/.config/waybar
cat ~/.config/waybar/config.jsonc
cat ~/.config/waybar/style.css
```
