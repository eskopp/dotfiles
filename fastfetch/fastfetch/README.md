# Fastfetch

This directory contains the Fastfetch configuration for this dotfiles repository.

## Purpose

The Fastfetch setup in this repository provides a compact system overview
with a small logo, icon-based keys, and a simple Nord-friendly terminal layout.

It is designed to show:

- user and host information
- operating system and host details
- kernel and uptime
- desktop environment and window manager
- terminal and shell
- CPU, GPU, memory, and disk
- local IP information
- a color palette preview

## Files

The current Fastfetch setup consists of:

- `fastfetch/fastfetch/config.jsonc`

When installed through GNU Stow, this file ends up at:

- `~/.config/fastfetch/config.jsonc`

## Installation

Fastfetch is installed by the repository install script.

Run:

```sh
./install.sh
```

The repository uses GNU Stow.
The `fastfetch` package is applied to `~/.config`.

You can also restow only Fastfetch manually:

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" fastfetch
```

## Current behavior

The current config uses:

- a small logo
- top padding and right padding for the logo
- a simple separator
- colored keys and title
- fixed key width
- a hand-picked list of modules

## Current structure

The config currently contains these top-level areas:

- `$schema`
- `logo`
- `display`
- `modules`

## Logo settings

The logo is configured as:

```json
"logo": {
  "type": "small",
  "padding": {
    "top": 1,
    "right": 3
  }
}
```

This gives a compact layout with a bit of spacing around the logo.

## Display settings

The display section currently sets:

- separator spacing
- key color
- title color
- key width

Example:

```json
"display": {
  "separator": "  ",
  "color": {
    "keys": "blue",
    "title": "cyan"
  },
  "key": {
    "width": 12
  }
}
```

## Modules

The current module list includes:

- title
- break
- os
- host
- kernel
- uptime
- de
- wm
- terminal
- shell
- cpu
- gpu
- memory
- disk
- localip
- break
- colors

## Included information

### Title

Shows:

- user name
- host name

### System information

The config shows:

- operating system
- host
- kernel
- uptime

### Desktop information

The config shows:

- desktop environment
- window manager
- terminal
- shell

### Hardware information

The config shows:

- CPU
- GPU
- memory
- disk usage for `/`

### Network information

The config shows:

- local IPv4 address
- interface name

### Colors module

At the end, the colors module shows a small terminal color palette preview.

## Current modules in practice

The output is intended to be short and readable.
It avoids overly noisy information and keeps the visible output focused on daily-use information.

## Usage

Run Fastfetch with the repo config through the normal installed path:

```sh
fastfetch
```

You can also point Fastfetch at the config file directly:

```sh
fastfetch --config ~/.config/fastfetch/config.jsonc
```

## File structure in the repo

```text
fastfetch/
└── fastfetch
    ├── config.jsonc
    └── README.md
```

## Useful commands

### Check the installed config

```sh
ls -l ~/.config/fastfetch
cat ~/.config/fastfetch/config.jsonc
```

### Restow only the Fastfetch package

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" fastfetch
```

### Run Fastfetch

```sh
fastfetch
```

### Run Fastfetch with an explicit config path

```sh
fastfetch --config ~/.config/fastfetch/config.jsonc
```

## Notes

This Fastfetch setup is intentionally simple.
It uses a small logo, compact spacing, and a hand-selected module list instead of showing everything available.

If you already have a local Fastfetch config, the repo install logic may back it up before Stow links the repo-managed version.

## Troubleshooting

### Fastfetch does not start

Run it directly:

```sh
fastfetch
```

### The config is not applied

Check whether the installed config exists at:

```sh
ls -l ~/.config/fastfetch/config.jsonc
```

### The shown modules are not what you expect

Inspect the installed config:

```sh
cat ~/.config/fastfetch/config.jsonc
```

### The output looks wrong after config changes

Restow the package again:

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" fastfetch
```

## Summary

This folder contains the Fastfetch configuration for the repository, including:

- compact logo settings
- simple display styling
- a curated set of modules
- local system and network information
- Stow-managed installation into `~/.config/fastfetch/config.jsonc`
