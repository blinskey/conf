#!/bin/sh
#
# Portable script to deploy config files. Must be run from config file
# repo directory. Note that some files will be overridden regardless of
# whether the -y option is used.

# TODO:
# - Append .gtkrc-2.0 contents rather than overwriting?
# - Respect -y for all files.
# - Provide option to install realpath if missing.
# - Provide option to install software.

readonly TRUE=1
readonly FALSE=0

# argument (optional): 2 to write to stderr, 1 or anything else to write to
# stdout; defaults to 1
usage() {
    fd=1

    if [ "$1" -eq 2 ]; then
        fd=2
    fi

    {
        echo "Usage: $(basename "$0") [OPTION]"
        echo
        echo "Options:"
        echo "-h          display this usage information and exit"
        echo "-y          overwrite existing files without prompting"
    } >&"$fd"
}

link() {
    if [ "$yes" ]; then
        ln -s "$(realpath "$1")" ~
    else
        ln -si "$(realpath "$1")" ~
    fi
}

if [ ! -x "$(command -v realpath)" ]; then
    echo "realpath must be installed." >&2
    exit 1
fi

while getopts hy name; do
    case $name in
    h)  usage
        exit 0
        ;;
    y)  yes=TRUE
        ;;
    ?)  usage 2
        exit 2
        ;;
    esac
done

link .bash_aliases
link .bashrc
link .crawlrc
link .eslintrc
link .ideavimrc
link .jsbeautifyrc
link .lynxrc
link .tmux.conf
link .vim
link .vimrc
link .zsh_aliases
link .zshenv
link .zshrc

if [ -f ~/.config/sublime-text-3/Packages/User ]; then
    rm -rf ~/.config/sublime-text-3/Packages/User
    ln -s "$(realpath .config/sublime-text-3/Packages/User)" \
           ~/.config/sublime-text-3/Packages/User
fi

if [ -x "$(command -v xfce4-terminal)" ]; then
    mkdir -p ~/.config/xfce4/terminal
    ln -s "$(realpath .config/xfce4/terminal/terminalrc)" \
           ~/.config/xfce4/terminal/terminalrc
fi

if [ -x "$(command -v xfce4-popup-whiskermenu)" ]; then
   link .gtkrc-2.0
fi

if [ -x "$(command -v lynx)" ] && [ -d /etc/lynx-cur ]; then
    ln -sr "$(realpath tc/lynx-cur/lynx.cfg)" \
           /etc/lynx-cur/lynx.cfg
fi
