# Dotfiles

## Installation

`install.sh` will set up most files. Copy `private.mutt` to `~/.mutt/private`
and replace the placeholder values.

## Details

### .Xresources

This is a modified version of the [Iceberg .Xresources file][0].

### Gnome Terminal settings

- Dump: `dconf dump /org/gnome/terminal/legacy/ > other/gnome-terminal.dconf`
- Load: `dconf load /org/gnome/terminal/legacy/ < other/gnome-terminal.dconf`

The colors used in the Iceberg profile are identical to the values in
`.Xresources`.

[0]: https://gist.github.com/cocopon/1d481941907d12db7a0df2f8806cfd41
