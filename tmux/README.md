# tmux

This directory contains the tmux configuration for this dotfiles repository.

## Purpose

The goal of this tmux setup is:

- a simple terminal multiplexer workflow
- a dark Nord look
- sane defaults for panes, windows, mouse support, and history
- easy deployment through GNU Stow

The actual tmux configuration file in this repo is:

- `tmux/.tmux.conf`

When installed through the repo, it is linked to:

- `~/.tmux.conf`

## Installation

`tmux` is installed by the repository install script.

Run:

```sh
./install.sh
```

The repo uses GNU Stow. The tmux package is applied to the home directory, so:

- `tmux/.tmux.conf` → `~/.tmux.conf`

You can also apply only the tmux package manually:

```sh
stow --no-folding --restow --dir ~/git/dotfiles --target "$HOME" tmux
```

## Reloading the config

Inside tmux, reload the config with:

- `Prefix + r`

In this setup, the prefix key is:

- `Ctrl + a`

So the full reload shortcut is:

- `Ctrl + b`, then `r`

## Main behavior

This config enables the following defaults:

- mouse support is enabled
- scrollback history is increased
- window numbering starts at `1`
- pane numbering starts at `1`
- window numbers are renumbered automatically
- the tmux prefix uses the default `Ctrl + b`

## Key behavior in this config

### Prefix

Default tmux prefix:

- `Ctrl + b`

The tmux prefix in this setup is:

- `Ctrl + b`

You can send the prefix key itself through tmux with:

- `Ctrl + b`, then `Ctrl + b`

## Useful standard tmux shortcuts

These are the most important tmux keybindings to know when using this setup.

All of the following start with the tmux prefix:

- `Ctrl + b`

### Session and window management

- `Prefix + c` → create a new window
- `Prefix + ,` → rename current window
- `Prefix + &` → close current window
- `Prefix + n` → next window
- `Prefix + p` → previous window
- `Prefix + 0..9` → switch to a specific window by number

### Pane management

- `Prefix + s` → split pane horizontally
- `Prefix + v` → split pane vertically
- `Prefix + x` → close current pane
- `Prefix + o` → move to the next pane
- `Prefix + h` → focus pane left
- `Prefix + j` → focus pane down
- `Prefix + k` → focus pane up
- `Prefix + l` → focus pane right
- `Prefix + H` → resize pane left
- `Prefix + J` → resize pane down
- `Prefix + K` → resize pane up
- `Prefix + L` → resize pane right
- `Prefix + q` → show pane numbers
- `Prefix + z` → zoom/unzoom current pane

### Copy mode and scrolling

Because mouse support is enabled, you can:

- select panes with the mouse
- resize panes with the mouse in supporting terminals
- scroll with the mouse wheel in tmux history

Useful keyboard actions:

- `Prefix + [` → enter copy mode
- `q` → leave copy mode

## Visual design

This tmux theme uses only official Nord colors and keeps the look intentionally dark and minimal.

### Theme goals

- dark status bar
- subtle inactive borders
- clear active pane highlight
- simple window list without flashy blocks

### Design choices

- background uses dark Nord base tones
- active pane border uses a Frost accent color
- inactive windows are muted
- the active window is brighter and bold
- the status bar stays visually quiet

## What is configured

The config currently sets:

- `mouse on`
- `history-limit 100000`
- `base-index 1`
- `pane-base-index 1`
- `renumber-windows on`
- `prefix C-b`
- custom pane split bindings on `s` and `v`
- pane movement on `h`, `j`, `k`, `l`
- pane resizing on `H`, `J`, `K`, `L`
- a dark Nord status line
- Nord pane border colors
- a reload binding on `Prefix + r`

## File structure

Inside the repo:

```text
tmux/
├── .tmux.conf
└── README.md
```

## Notes

If you already have a local `~/.tmux.conf`, the repo install logic may back it up before Stow links the repo-managed file.

To test whether the config is active, start tmux and check:

- the prefix is `Ctrl + b`
- the status bar has the dark Nord styling
- `Prefix + s` and `Prefix + v` split panes
- `Prefix + r` reloads the config

## Start tmux

Run:

```sh
tmux
```

## Attach to an existing session

Run:

```sh
tmux attach
```

Or list sessions first:

```sh
tmux ls
```
