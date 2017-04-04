readonly os_name="$(uname)"

export PS1="[\u@\h:\w]\\$ "

set -o vi

alias gpg=gpg2

if [ "$os_name" = "OpenBSD" ]; then
    alias sudo=doas
fi

# ls aliases
alias l='ls -CF'
alias la='ls -A'

# Linux, FreeBSD, and Darwin have the -b option, but OpenBSD doesn't.
if [ "$os_name" = "OpenBSD" ]; then
    alias ll='ls -AhlF'
else
    alias ll='ls -AhlFb'
fi

# Use color for lll on Linux.
if [ "$os_name" = "Linux" ]; then
    alias lll='ll --color=always | less -R'
else
    alias lll='ll | less'
fi
