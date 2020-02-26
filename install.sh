#!/bin/sh

set -eu

# Delete any pre-installed ~/.bash_profile. We use a universal ~/.profile for
# bash and ksh instead.
rm -f $HOME/.bash_profile

mkdir -p $HOME/.config/nvim
ln -sf $PWD/other/nvim/init.vim $HOME/.config/nvim/init.vim

# Load Gnome Terminal settings.
if [ -x "$(command -v dconf)" ]; then
    dconf load /org/gnome/terminal/legacy/ < other/gnome-terminal.dconf
fi

# Load WSL settings.
if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
	# Create a link to Windows home directory in WSL home directory.
	rm $HOME/win-home
	ln -s '/mnt/c/Users/Benjamin Linskey' $HOME/win-home

	# Install terminal in regular Windows filesystem, then link it to WSL home
	# directory.
	win_term_prof=$HOME/win-home/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/profiles.json
	cp other/windows-terminal-profiles.json $win_term_prof
	ln -sf $win_term_prof $HOME/.windows-terminal-profiles.json
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
