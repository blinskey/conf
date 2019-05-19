#!/bin/sh

mkdir -p $HOME/.config/cmus
ln -sf $PWD/other/cmusrc $HOME/.config/cmus/rc

# Load Gnome Terminal settings.
if [ -x "$(command -v dconf)" ]; then
    dconf load /org/gnome/terminal/legacy/ < other/gnome-terminal.dconf
fi

cd home
for f in .*; do
    if [ $f != . ] \
            && [ $f != .. ] \
            && [ $f != .git ] \
            && [ $f != .gitignore ]; then
        ln -sf $PWD/$f $HOME
    fi
done
