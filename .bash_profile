# .bash_profile

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$GOPATH/bin

# Add MacPorts bin directories on Mac.
if [ "$(uname)" == "Darwin" ]; then
    PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

# GPG configuration
export GPG_TTY=$(tty)
export GPGKEY=838AA558

# Lynx
export LYNX_CFG_PATH=~/.lynx:/etc/lynx:/etc
if [ -f ~/.lynx/lynx.cfg ]; then
    export LYNX_CFG=~/.lynx/lynx.cfg
fi

# Set editor.
if type vim >/dev/null; then
    export VISUAL=vim
else
    export VISUAL=vi
fi
export EDITOR="$VISUAL"

# Don't kill shell due to inactivity.
unset TMOUT
