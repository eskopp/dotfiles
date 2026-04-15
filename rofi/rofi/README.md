# Rofi

This directory contains the Rofi configuration for this dotfiles repository.

## Purpose

The Rofi setup in this repository is used as the main application launcher
and general quick menu for the desktop environment.

It is designed to provide:

- a clean launcher for desktop applications
- a dark Nord look
- icon support
- access to multiple modes such as app launch, command launch, and window switching

## Files

The current Rofi setup consists of:

- `rofi/rofi/config.rasi`
- `rofi/rofi/nord-theme.rasi`

When installed through GNU Stow, these files end up at:

- `~/.config/rofi/config.rasi`
- `~/.config/rofi/nord-theme.rasi`

## Installation

Rofi is installed by the repository install script.

Run:

```sh
./install.sh
```

The repository uses GNU Stow.
The `rofi` package is applied to `~/.config`.

You can also restow only Rofi manually:

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" rofi
```

## How the configuration works

The main configuration file is:

- `config.rasi`

This file defines the general Rofi behavior such as:

- enabled modes
- icon support
- icon theme
- terminal command
- launcher layout basics

At the end of that file, the theme is loaded through:

```rasi
@theme "~/.config/rofi/nord-theme.rasi"
```

The visual appearance is therefore mainly controlled by:

- `nord-theme.rasi`

## Enabled modes

The current setup enables these Rofi modes:

- `drun`
- `run`
- `window`

### `drun`

Used for launching desktop applications from `.desktop` files.

Example:

```sh
rofi -show drun
```

### `run`

Used for launching commands directly.

Example:

```sh
rofi -show run
```

### `window`

Used for switching between open windows.

Example:

```sh
rofi -show window
```

## Theme

The Rofi theme is defined in:

- `rofi/rofi/nord-theme.rasi`

This theme provides:

- a dark Nord background
- Frost accent colors
- rounded corners
- styled input bar
- styled mode switcher buttons
- highlighted selected entries
- support for error message styling

## Theme structure

The theme defines values for things such as:

- background colors
- surface colors
- foreground and muted text colors
- accent colors
- success / warning / error colors
- border colors
- selected entry colors

These values are then applied to:

- `window`
- `mainbox`
- `inputbar`
- `prompt`
- `entry`
- `mode-switcher`
- `button`
- `listview`
- `element`
- `error-message`

## General behavior

The current configuration includes:

- icons enabled
- Papirus as icon theme
- launcher centered on screen
- hidden scrollbar
- command history enabled
- `drun`, `run`, and `window` modes available

## Usage in the desktop setup

Rofi is used as the application launcher from Hyprland.

Typical usage in the repository is through a command like:

```sh
rofi -show drun
```

This is commonly connected to a keybinding in the Hyprland configuration.

## File structure in the repo

```text
rofi/
└── rofi
    ├── config.rasi
    ├── nord-theme.rasi
    └── README.md
```

## Useful commands

### Start the application launcher

```sh
rofi -show drun
```

### Start command mode

```sh
rofi -show run
```

### Start window switcher mode

```sh
rofi -show window
```

### Check the installed config files

```sh
ls -l ~/.config/rofi
cat ~/.config/rofi/config.rasi
cat ~/.config/rofi/nord-theme.rasi
```

## Troubleshooting

### Rofi does not start

Run it directly to see whether it prints an error:

```sh
rofi -show drun
```

### The theme does not load

Check whether the theme file exists at the expected location:

```sh
ls -l ~/.config/rofi/nord-theme.rasi
```

Also verify that `config.rasi` still contains:

```rasi
@theme "~/.config/rofi/nord-theme.rasi"
```

### Icons do not appear

Check:

- whether icon support is enabled in `config.rasi`
- whether the configured icon theme is installed
- whether the applications provide valid desktop entries and icons

### A menu entry opens the wrong terminal

Check the `terminal:` setting in:

- `~/.config/rofi/config.rasi`

## Notes

If you already have a local Rofi configuration, the repo install logic may back it up before Stow links the repo-managed files.

This setup keeps behavior and theme separate:

- `config.rasi` controls behavior
- `nord-theme.rasi` controls appearance

That makes it easier to adjust launcher behavior without rewriting the whole theme.

## Summary

This folder contains the Rofi launcher setup for the repository, including:

- general Rofi behavior
- a Nord-styled theme
- launcher, run, and window modes
- Stow-managed configuration files
