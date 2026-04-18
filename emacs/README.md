# Emacs

Minimal Emacs setup for this dotfiles repository with a local bundled Nord theme.

## Features

- Nord theme bundled directly in the repo
- XDG-style config layout via GNU Stow
- Minimal UI without menu bar, tool bar, or scroll bar
- Relative line numbers in useful buffers
- Highlighted current line
- Matching parentheses and automatic pair insertion
- Optional Hyprland window opacity support

## Repository Layout

- `emacs/emacs/init.el` — main Emacs configuration
- `emacs/emacs/early-init.el` — early startup configuration
- `emacs/emacs/themes/nord-theme.el` — bundled Nord theme
- `emacs/.stow-local-ignore` — prevents non-runtime files from being deployed
- `emacs/upstream-nord/` — upstream Nord reference files kept in the repo

## Install Location

After running Stow, the active files are available at:

- `~/.config/emacs/init.el`
- `~/.config/emacs/early-init.el`
- `~/.config/emacs/themes/nord-theme.el`

## Installation

From the dotfiles repository root:

    stow -Rv -t ~/.config emacs

## Start Emacs

Start the graphical version:

    emacs

Start without the splash screen:

    emacs --no-splash

Start inside the terminal:

    emacs -nw

## Notes

The Nord theme is loaded from the local `themes/` directory instead of being installed from MELPA.

This makes the setup more reproducible and avoids relying on external theme downloads during installation.

## Hyprland Opacity

If Hyprland is used, Emacs window opacity can be controlled through the Hyprland config.

Example rule:

    windowrule = match:class ^(emacs)$, opacity 0.80 override 0.80 override 1.0 override
