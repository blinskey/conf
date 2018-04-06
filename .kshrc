# .kshrc -- ksh configuration file
#
# To use this file, specify its location in the  ENV paramater in ~/.profile:
#
# 	export ENV=$HOME/.kshrc
#
# This is primarily targeted at OpenBSD's ksh but should also work with other
# versions in the pdksh lineage as well as the AT&T ksh.

# Set the history file location.
HISTFILE="$HOME/.sh_history"

if [ "$(uname)" = OpenBSD ]; then
    # Enable csh-style history editing.
    set -o csh-history

    # Enable tab completion in vi mode, which isn't the default everywhere.
    set -o vi-tabcomplete

    # Set the prompt. Most versions of ksh don't support the escape codes
    # defined in the OpenBSD version.
    PS1="[\u@\h:\W]\\$ "
else
    PS1="[$(id -un)@$(hostname -s):$(basename $PWD)]\\$ "
fi

if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi
