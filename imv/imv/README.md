# imv

This directory contains the imv configuration for this dotfiles repository.

## Purpose

The imv setup in this repository provides a lightweight image viewer configuration
for the desktop environment.

It is designed to give:

- a simple image viewer for Wayland/X11 use
- a minimal on-screen overlay
- a clean title showing the current file
- a small, low-maintenance config that fits the rest of the setup

## Files

The current imv setup consists of:

- `imv/imv/config`

When installed through GNU Stow, this file ends up at:

- `~/.config/imv/config`

## Installation

imv is installed by the repository install script.

Run:

```sh
./install.sh
```

The repository uses GNU Stow.
The `imv` package is applied to `~/.config`.

You can also restow only imv manually:

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" imv
```

## Current behavior

The current config is intentionally very small.

It currently enables:

- overlay text
- bottom overlay placement
- the current file path as overlay text
- the current file path as the window title

## Current settings

The active settings are:

```ini
[options]
overlay = true
overlay_position_bottom = true
overlay_text = $imv_current_file
title_text = $imv_current_file
```

## What these settings do

### Overlay

```ini
overlay = true
```

This enables the on-screen overlay.

### Overlay position

```ini
overlay_position_bottom = true
```

This places the overlay at the bottom of the image area.

### Overlay text

```ini
overlay_text = $imv_current_file
```

This shows the current file path in the overlay.

### Window title

```ini
title_text = $imv_current_file
```

This sets the window title to the current file path.

## Usage

Start imv with a file:

```sh
imv image.png
```

Start imv in the current directory:

```sh
imv .
```

Open multiple files:

```sh
imv *.png
```

## File structure in the repo

```text
imv/
└── imv
    ├── config
    └── README.md
```

## Useful commands

### Check the installed config

```sh
ls -l ~/.config/imv
cat ~/.config/imv/config
```

### Restow only the imv package

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME/.config" imv
```

### Start imv

```sh
imv .
```

## Notes

This imv setup is intentionally minimal.
It does not try to heavily style or customize imv.
Instead, it only adds the small quality-of-life settings that are useful in daily use.

If you already have a local imv config, the repo install logic may back it up before Stow links the repo-managed version.

## Troubleshooting

### imv does not start

Run it directly to see whether it prints an error:

```sh
imv .
```

### The config is not applied

Check whether the installed config exists at:

```sh
ls -l ~/.config/imv/config
```

### The overlay does not look right

Inspect the installed config:

```sh
cat ~/.config/imv/config
```

## Summary

This folder contains the imv configuration for the repository, including:

- overlay support
- bottom overlay positioning
- current file path in the overlay
- current file path in the title bar
- Stow-managed installation into `~/.config/imv/config`
