# vim:ts=4:sw=4

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

readonly OS_NAME="$(uname)"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Append to the history file, don't overwrite it.
shopt -s histappend

# Turn on parallel history
history -a

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Set maximum number of commands and lines in history file.
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

make_prompt() {
    # If we're in a virtualenv, show its name.
    if [ -n "$VIRTUAL_ENV" ]; then
        env_name=$(basename $VIRTUAL_ENV)
        venv="($env_name)"
    else
        venv=""
    fi

    PS1="[\u@\h:\W]${venv}\\$ "
}
PROMPT_COMMAND=make_prompt

# globstar: Available starting in Bash 4.0.
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
if [ ${BASH_VERSION:0:1} -gt 3 ]; then
    shopt -s globstar
fi

# Set pager.
export PAGER="less"

# Active lesspipe if present. (Commonly installed by default on Linux.)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set editor.
if type vim >/dev/null; then
    export VISUAL=vim
else
    export VISUAL=vi
fi
export EDITOR="$VISUAL"

# Use vi keybindings.
set -o vi
bind -m vi-insert '"\C-p": previous-history'
bind -m vi-insert '"\C-n": next-history'
bind -m vi-insert '"\C-l": clear-screen'

# less options:
# -X: Disable termcap initialization and deinitialization strings (so pager
#     display won't be cleared from screen on exit)
export LESS=-X

# GPG configuration
export GPG_TTY=$(tty)
export GPGKEY=838AA558

# ls aliases
alias l='ls -CF'
alias la='ls -A'

# Linux, FreeBSD, and Darwin have the -b option, but OpenBSD doesn't.
if [ "$OS_NAME" = "OpenBSD" ]; then
    alias ll='ls -AhlF'
else
    alias ll='ls -AhlFb'
fi

# Always start tmux in 256-color mode.
alias tmux='tmux -2'

export GOPATH=$HOME/go
export PATH="$PATH:$HOME/bin:$GOPATH/bin"
export PYTHONPATH="$PATH:"

# Directories in which to search for Lynx config files (excluding .lynxrc,
# which must always be in the home directory)
export LYNX_CFG_PATH=~/.lynx:/etc/lynx:/etc

if [ -f ~/.lynx/lynx.cfg ]; then
    export LYNX_CFG=~/.lynx/lynx.cfg
fi

# UTF-8 on FreeBSD (requires the vt console driver; see vt(4)).
if [ "$OS_NAME" = "FreeBSD" ]; then
    export CHARSET="UTF-8"
    export LANG="en_US.UTF-8"
fi
