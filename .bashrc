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

# Use vi keybindings.
set -o vi

PS1="\h\\$ "

if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi
