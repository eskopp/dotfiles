# Nano

Minimal Nano configuration for this dotfiles repository, styled to fit the Nord-inspired setup used across the rest of the desktop.

## Overview

This package installs a user Nano configuration at:

`~/.config/nano/nanorc`

The file is managed through the dotfiles installer and linked with GNU Stow.

## Features

- Nord-inspired interface colors
- Line numbers
- Mouse support
- Soft wrapping
- Auto indentation
- Position and history tracking
- 80-column guide stripe
- Loads system syntax definitions from `/usr/share/nano/*.nanorc`

## Installation

Nano is installed through `install.sh` and linked as part of the normal dotfiles setup.

## Notes

The vertical line in the editor comes from:

`set guidestripe 80`

It acts as a visual guide for line length and can be changed or removed in `nanorc` if needed.
