#!/bin/sh

set -eu

# Delete any pre-installed ~/.bash_profile. We use a universal ~/.profile for
# bash and ksh instead.
rm $HOME/.bash_profile

if [ $(uname) = Linux ]; then
    echo "Running on Linux. Unwanted files in /etc will be removed."
    echo "Running commands under sudo. You may be prompted for a password."

    # Disable any pre-installed global Vim customizations.
    if [ -f /etc/vimrc ]; then
        sudo mv /etc/vimrc /etc/vimrc.default
    fi

    if [ -f /etc/virc ]; then
        sudo mv /etc/virc /etc/virc.default
    fi

    if [ ! -d /etc/profile.d.defaults ]; then
        sudo cp -r /etc/profile.d /etc/profile.d.defaults
    fi

    orig_dir=$PWD
    cd /etc/profile.d
    sudo rm color* vim* less* which*
    cd $orig_dir
fi

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
