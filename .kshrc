readonly OS_NAME="$(uname)"

venv_segment() {
    # If we're in a virtualenv, show its name.
    if [ -n "$VIRTUAL_ENV" ]; then
        env_name=$(basename $VIRTUAL_ENV)
        echo "[$env_name]"
    fi
}

PS1="$(venv_segment)[\u@\h:\W]\\$ "
#export PS1="[\u@\h:\w]\\$ "

set -o vi

alias gpg=gpg2

if [ "$OS_NAME" = "OpenBSD" ]; then
    alias sudo=doas
fi

# ls aliases
alias l='ls -CF'
alias la='ls -A'

# Linux, FreeBSD, and Darwin have the -b option, but OpenBSD doesn't.
# FreeBSD and Darwin have the -G option, but OpenBSD doesn't.
if [ "$OS_NAME" = "OpenBSD" ]; then
    alias ll='ls -AhlF'
elif [ "$OS_NAME" = "FreeBSD" ] || [ "$OS_NAME" = "Darwin" ]; then
    alias ll='ls -AhlFbG'
else
    # Linux
    alias ll='ls -AhlFb'
fi

# Use color for lll on Linux.
if [ "$OS_NAME" = "Linux" ]; then
    alias lll='ll --color=always | less -R'
else
    alias lll='ll | less'
fi
