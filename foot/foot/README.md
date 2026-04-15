# Foot

This directory contains the Foot terminal configuration for this dotfiles repository.

## Purpose

The Foot setup in this repository provides a Wayland-native terminal configuration
with a dark Nord look and simple defaults.

It is designed to give:

- a lightweight terminal for Wayland
- a dark Nord color scheme
- a minimal and readable configuration
- sane defaults for cursor behavior, font size, and terminal colors

## Files

The current Foot setup consists of:

- `foot/foot/foot.ini`

When installed through GNU Stow, this file ends up at:

- `~/.config/foot/foot.ini`

## Installation

Foot is installed by the repository install script.

Run:

```sh
./install.sh
```

The repository uses GNU Stow.
The `foot` package is applied to `~/.config`.

You can also restow only Foot manually:

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" foot
```

## Current behavior

The current config is intentionally small and focused.

It currently defines:

- the terminal type
- the font
- cursor style
- cursor blinking behavior
- a dark color theme
- normal ANSI colors
- bright ANSI colors

## Current structure

The config currently contains these sections:

- `[main]`
- `[cursor]`
- `[colors-dark]`

## Main section

The main section currently defines the terminal type and font.

Example:

```ini
[main]
term=foot
font=monospace:size=11.5
```

### `term=foot`

This sets the terminal type used by Foot.

### `font=...`

This defines the font and size used in the terminal.

## Cursor section

The cursor section currently defines:

- block cursor style
- blinking disabled

Example:

```ini
[cursor]
style=block
blink=no
```

## Color theme

The terminal colors are defined in:

- `[colors-dark]`

This is the dark color theme section.

It currently provides:

- foreground color
- background color
- the normal ANSI color set
- the bright ANSI color set

The current theme is based on official Nord colors.

## Current color roles

The config defines at least these color groups:

- foreground
- background
- `regular0` to `regular7`
- `bright0` to `bright7`

This covers the standard terminal palette for normal and bright colors.

## Usage

Start Foot normally:

```sh
foot
```

Run a command in Foot:

```sh
foot bash -lc 'echo hello'
```

Open a shell and keep working inside the terminal:

```sh
foot
```

## File structure in the repo

```text
foot/
└── foot
    ├── foot.ini
    └── README.md
```

## Useful commands

### Check the installed config

```sh
ls -l ~/.config/foot
cat ~/.config/foot/foot.ini
```

### Restow only the Foot package

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" foot
```

### Validate the Foot config

```sh
foot --check-config
```

### Start Foot

```sh
foot
```

## Notes

This Foot setup is intended to stay simple and readable.
It focuses on terminal basics instead of large feature-heavy customization.

If you already have a local Foot config, the repo install logic may back it up before Stow links the repo-managed version.

Because Foot is a Wayland-native terminal, it is a natural fit for the rest of this repository's Hyprland-based setup.

## Troubleshooting

### Foot does not start

Run it directly:

```sh
foot
```

### Check the config for errors

```sh
foot --check-config
```

### The config is not applied

Check whether the installed config exists at:

```sh
ls -l ~/.config/foot/foot.ini
```

### The colors are not what you expect

Inspect the installed config:

```sh
cat ~/.config/foot/foot.ini
```

## Summary

This folder contains the Foot terminal configuration for the repository, including:

- terminal type configuration
- font selection
- cursor behavior
- dark Nord colors
- Stow-managed installation into `~/.config/foot/foot.ini`
