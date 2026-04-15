# Scripts

This directory contains helper scripts used by the dotfiles repository.

## Purpose

The scripts in this folder are mainly used to support installation,
Stow deployment, shell setup, and migration of existing local config files
into the repository structure.

## Files

The current scripts are:

- `scripts/common.sh`
- `scripts/install_zsh.sh`
- `scripts/adopt-bashrc.sh`

## Overview

### `common.sh`

This is the shared helper library used by the main install and uninstall logic.

It contains functions for:

- logging (`info`, `warn`, `die`)
- checking that the system is Arch Linux
- requesting and keeping `sudo` alive
- creating required directories
- installing packages with `pacman`
- marking repo helper binaries as executable
- preparing the Stow tree
- backing up conflicting target files
- applying and removing Stow packages

This file is meant to be **sourced** by other scripts and is not usually run directly.

### `install_zsh.sh`

This script installs and configures the Zsh environment.

It currently handles:

- installation of `zsh`, `git`, `curl`, and `zoxide`
- installation of Oh My Zsh
- cloning or updating the `zsh-autocomplete` plugin
- setting Zsh as the default shell
- basic validation that the required tools exist

This script is normally called by:

```sh
./install.sh
```

but it can also be run manually if needed:

```sh
bash ./scripts/install_zsh.sh
```

### `adopt-bashrc.sh`

This script helps migrate an existing `~/.bashrc` into the dotfiles repository.

It does the following:

- checks that you are inside the git repository
- creates a backup of the current `~/.bashrc`
- copies the current Bash config into the repo if needed
- links `~/.bashrc` to the repo-managed version
- stages and commits the change

Example:

```sh
bash ./scripts/adopt-bashrc.sh "Add bashrc to dotfiles"
```

## How these scripts are used

### Main installation flow

The normal installation entrypoint is:

```sh
./install.sh
```

That top-level script uses the helper scripts from this directory.

In practice:

- `install.sh` sources `scripts/common.sh`
- `install.sh` calls `scripts/install_zsh.sh`
- `uninstall.sh` also sources `scripts/common.sh`

## Notes

### `common.sh` is internal infrastructure

You normally do not run `common.sh` directly.

It is intended to be sourced like this:

```sh
source "./scripts/common.sh"
```

### GNU Stow integration

The helper functions in `common.sh` are responsible for:

- backing up existing files before linking
- restowing repo-managed packages
- removing repo-managed symlinks during uninstall

### Backup behavior

When a target already exists and is not a repo-managed symlink,
the backup logic moves it into a timestamped backup directory.

This helps avoid accidental data loss during installation.

## File structure

```text
scripts/
├── adopt-bashrc.sh
├── common.sh
└── install_zsh.sh
```

## Typical manual commands

### Run the full install

```sh
./install.sh
```

### Run only the Zsh setup

```sh
bash ./scripts/install_zsh.sh
```

### Adopt the current Bash config into the repo

```sh
bash ./scripts/adopt-bashrc.sh
```

### Inspect the scripts

```sh
ls -l scripts
sed -n '1,260p' scripts/common.sh
sed -n '1,260p' scripts/install_zsh.sh
sed -n '1,260p' scripts/adopt-bashrc.sh
```

## Troubleshooting

### A script says a command is missing

Make sure required packages are installed, especially:

```sh
sudo pacman -S git curl zsh zoxide stow
```

### Installation stops because of conflicts

Check the backup directory that the install helpers create for moved files.

### A Stow link was not applied

Inspect:

```sh
ls -l ~/.config
ls -l ~/.local/bin
```

and then rerun the installer if needed.

## Summary

This folder contains the reusable shell scripts that power the repository's:

- installation logic
- Stow deployment
- shell setup
- migration helpers
