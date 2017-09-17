# .kshrc -- ksh configuration file
#
# To use this file, specify its location in the  ENV paramater in ~/.profile:
#
# 	export ENV=$HOME/.kshrc

readonly OS=$(uname)

# Set the history file location.
HISTFILE="$HOME/.sh_history"

# Set up some ls aliases.
alias l='ls -CFA'
alias ll='ls -AhlF'

# Enable csh-style history editing.
if [ "$OS" = OpenBSD ]; then
    set -o csh-history
fi

# Enable tab completion in vi mode, which isn't the default everywhere.
set -o vi-tabcomplete

# Prints the name of the current Python virtualenv. Does nothing if a
# virtualenv is not activated.
prompt_venv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "($(basename $VIRTUAL_ENV))"
    fi
}

# Prints the basename of the working directory, or a tilde if the PWD is $HOME.
# This performs the same function as the \W escape sequence in OpenBSD's ksh.
prompt_dir() {
	if [ "$PWD" = "$HOME" ]; then
		echo '~'
	else
		echo $(basename "$PWD")
	fi
}

# Set the prompt. Most versions of ksh don't support the escape codes defined
# in the OpenBSD version.
if [ "$OS" = OpenBSD ]; then
	PS1='$(prompt_venv)[\u@\h:\W]\\$ '
else
	PS1='$(prompt_venv)[$USER@$(hostname -s):$(prompt_dir)]\\$ '
fi
