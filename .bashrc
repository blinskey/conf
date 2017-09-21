# Append to the history file, don't overwrite it.
shopt -s histappend

# Turn on parallel history.
history -a

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Set maximum number of commands and lines in history file.
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# globstar: Available starting in Bash 4.0.
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
if [ ${BASH_VERSION:0:1} -gt 3 ]; then
    shopt -s globstar
fi

# Active lesspipe if present. (Commonly installed by default on Linux.)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Use vi keybindings.
set -o vi

# ls aliases
alias l='ls -CFA'
alias ll='ls -AhlF'

make_prompt() {
    # If we're in a virtualenv, show its name.
    if [ -n "$VIRTUAL_ENV" ]; then
        env_name=$(basename $VIRTUAL_ENV)
        venv="($env_name)"
    else
        venv=""
    fi

    PS1="${venv}[\u@\h:\W]\\$ "
}
PROMPT_COMMAND=make_prompt
