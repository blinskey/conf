# Initialization for all Bourne-compatible shells.

GOPATH=$HOME/go
PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$HOME/.local/bin:$GOPATH/bin:/usr/ports/infrastructure/bin:/usr/games
export PATH HOME TERM GOPATH

if [ "$SHELL" == /bin/ksh ]; then
    export ENV=$HOME/.kshrc
elif [ "$SHELL" == /bin/bash ]; then
    . "$HOME/.bashrc"
fi

export LC_CTYPE=en_US.UTF-8

# UTF-8 on FreeBSD (requires the vt console driver; see vt(4)).
if [ "$(uname)" = "FreeBSD" ]; then
    export CHARSET="UTF-8"
    export LANG="en_US.UTF-8"
fi

# Set editor. Use vim if available, or vi otherwise.
if type vim >/dev/null; then
    export VISUAL=vim
else
    export VISUAL=vi
fi

# Don't kill shell due to inactivity.
unset TMOUT

export NO_COLOR