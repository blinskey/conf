# Dotfiles

## Installation

`install.sh` will set up most files. Copy `private.mutt` to `~/.mutt/private`
and replace the placeholder values.

## Gnome Terminal settings

- Dump: `dconf dump /org/gnome/terminal/legacy/ > other/gnome-terminal.dconf`
- Load: `dconf load /org/gnome/terminal/legacy/ < other/gnome-terminal.dconf`
