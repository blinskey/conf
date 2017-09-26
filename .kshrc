# .kshrc -- ksh configuration file
#
# To use this file, specify its location in the  ENV paramater in ~/.profile:
#
# 	export ENV=$HOME/.kshrc
#
# This is primarily targeted at OpenBSD's ksh but should also work with other
# versions in the pdksh lineage. The AT&T ksh is not supported.

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

# Prints the basename of the working directory, or a tilde if the PWD is $HOME.
# This performs the same function as the \W escape sequence in OpenBSD's ksh.
prompt_dir() {
    # On systems such as FreeBSD where /home is a symbolic link to /usr/home,
    # we need to resolve the link before we compare it to $PWD. Neither
    # readlink nor realpath is fully portable, so we just try the latter and
    # give up if it's not available.
    if type realpath >/dev/null && [ "$PWD" = "$(realpath $HOME)" ]; then
		echo '~'
	else
		echo $(basename "$PWD")
	fi
}

# Set the prompt. Most versions of ksh don't support the escape codes defined
# in the OpenBSD version.
if [ "$OS" = OpenBSD ]; then
	PS1='[\u@\h:\W]\\$ '
else
	PS1='[$USER@$(hostname -s):$(prompt_dir)]$ '
fi
