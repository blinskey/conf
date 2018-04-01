# sh/ksh initialization

GOPATH=$HOME/go
PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games:$HOME/bin:$GOPATH/bin:.

export PATH HOME TERM GOPATH

export ENV=$HOME/.kshrc

export LC_CTYPE=en_US.UTF-8

# Lynx
export LYNX_CFG_PATH=~/.lynx:/etc/lynx:/etc
if [ -f ~/.lynx/lynx.cfg ]; then
    export LYNX_CFG=~/.lynx/lynx.cfg
fi

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
