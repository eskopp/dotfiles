# Yazi

Simple Yazi configuration for my dotfiles setup.

## Contents

- Nord theme via `theme.toml`
- Installation with GNU Stow
- Launching via Hyprland keybinds

## Repository Structure

    yazi/.config/yazi/theme.toml
    yazi/README.md

## Installation

Inside the repository:

    cd ~/git/dotfiles
    stow yazi

## Launching

- `SUPER + O` launches `yazi .`
- `SUPER + P` launches `yazi /`

With `foot`:

    bind = $mainMod, O, exec, foot -e yazi .
    bind = $mainMod, P, exec, foot -e yazi /

## Note

After changing the Yazi configuration, just restart Yazi.
