# .kshrc -- ksh configuration file
#
# To use this file, specify its location in the  ENV paramater in ~/.profile:
#
# 	export ENV=$HOME/.kshrc

# Source the system-wide config file if it exists.
if [ -f /etc/ksh.kshrc ]; then
    . /etc/ksh.kshrc
fi

# Get the OS name so that we can configure system-specific settings, including
# fallbacks for versions of ksh that don't have all of the luxuries provided by
# the OpenBSD version.
readonly OS="$(uname)"

# Set the history file location.
HISTFILE="$HOME/.sh_history"

# Set editor. Use vim if available, or vi otherwise.
if type vim >/dev/null; then
    VISUAL=vim
else
    VISUAL=vi
fi

# PS1 helper function. Echoes the name of the current Python virtual
# environment, enclosed in brackets, or an empty string if a virtualenv is not
# active.
venv_segment() {
    # If we're in a virtualenv, show its name.
    if [ -n "$VIRTUAL_ENV" ]; then
        env_name=$(basename $VIRTUAL_ENV)
        echo "[$env_name]"
    fi
}

# Set the prompt.
if [ "$OS" = "OpenBSD" ]; then
    PS1="$(venv_segment)[\u@\h:\W]\\$ "
else
    PS1="$(venv_segment)[${USER}@$(hostname -s)]\\$ "
fi

# Use vi mode for command line editing.
set -o vi

# Set up some ls aliases. Linux, FreeBSD, and Darwin have the -b option, but
# OpenBSD doesn't.
alias l='ls -CFA'
if [ "$OS" = "OpenBSD" ]; then
    alias ll='ls -AhlF'
else
    alias ll='ls -AhlFb'
fi

# Enable csh-style history editing.
if [ "$OS" = "OpenBSD" ]; then
    set -o csh-history
fi
