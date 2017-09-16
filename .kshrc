# .kshrc -- ksh configuration file
#
# To use this file, specify its location in the  ENV paramater in ~/.profile:
#
# 	export ENV=$HOME/.kshrc

# Set the history file location.
HISTFILE="$HOME/.sh_history"

# Set editor. Use vim if available, or vi otherwise.
if type vim >/dev/null; then
    VISUAL=vim
else
    VISUAL=vi
fi

# Use vi mode for command line editing.
set -o vi

# Set up some ls aliases.
alias l='ls -CFA'
alias ll='ls -AhlF'
