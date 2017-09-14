readonly OS_NAME="$(uname)"

# Set pager.
export PAGER="less"

# less options:
# -X: Disable termcap initialization and deinitialization strings (so pager
#     display won't be cleared from screen on exit)
export LESS=-X


# Set editor.
if type vim >/dev/null; then
    export VISUAL=vim
else
    export VISUAL=vi
fi
export EDITOR="$VISUAL"

venv_segment() {
    # If we're in a virtualenv, show its name.
    if [ -n "$VIRTUAL_ENV" ]; then
        env_name=$(basename $VIRTUAL_ENV)
        echo "[$env_name]"
    fi
}

export PS1="$(venv_segment)[\u@\h:\W]\\$ "

set -o vi

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
