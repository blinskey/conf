# vim:ts=4:sw=4

# Set to 1 to enable color prompt.
readonly COLOR_PROMPT=1

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend

# Turn on parallel history
history -a

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set number of trailing directories to show in prompt with \w option.
PROMPT_DIRTRIM=3

# Color escape sequences
readonly RED="\[\e[31m\]"
readonly BRIGHT_RED="\[\e[1;31m\]"
readonly BRIGHT_YELLOW="\[\e[1;33m\]"
readonly BLUE="\[\e[34m\]"
readonly BRIGHT_BLUE="\[\e[1;34m\]"
readonly GREEN="\[\e[32m\]"
readonly BRIGHT_GREEN="\[\e[1;32m\]"
readonly RESET_COLOR="\[\e[0m\]"

readonly USER_COLOR=$BLUE
readonly DEFAULT_HOSTNAME_COLOR=$USER_COLOR
readonly PWD_COLOR=$GREEN

# If color prompt is enabled, create ~/.prompt-hostname-<color>  to change the
# color of the hostname in order to easily identify the machine.
if [ "$COLOR_PROMPT" -eq 1 ]; then
    if [ -f "${HOME}/.prompt-hostname-red" ]; then
        readonly HOSTNAME_COLOR="$BRIGHT_RED"
    elif [ -f "${HOME}/.prompt-hostname-yellow" ]; then
        readonly HOSTNAME_COLOR="$BRIGHT_YELLOW"
    else
        readonly HOSTNAME_COLOR="$DEFAULT_HOSTNAME_COLOR"
    fi
fi

# make_prompt() is run after each command and sets PS1. Color and non-versions
# contain the same content: username, truncated hostname, truncated path,
# and last exit code, if it was non-zero.
PROMPT_COMMAND=make_prompt
make_prompt() {
    exit_code="$?"

    if [ "$COLOR_PROMPT" -eq 1 ]; then
        if [ $exit_code == 0 ]; then
            PS1="[${USER_COLOR}\u${RESET_COLOR}@${HOSTNAME_COLOR}\h${RESET_COLOR}:${PWD_COLOR}\w${RESET_COLOR}]\\$ "
        else
            PS1="[${USER_COLOR}\u${RESET_COLOR}@${HOSTNAME_COLOR}\h${RESET_COLOR}:${PWD_COLOR}\w${RESET_COLOR}][${BRIGHT_RED}${exit_code}${RESET_COLOR}]\\$ "
        fi

    else
        if [ "$exit_code" == 0 ]; then
            PS1="[\u@\h:\w]\\$ "
        else
            PS1="[\u@\h:\w][${exit_code}]\\$ "
        fi
    fi

    # If we're in a virtualenv, show its name.
    if [ -n "$VIRTUAL_ENV" ]; then
        env_name=$(basename $VIRTUAL_ENV)
        PS1="[$env_name]$PS1"
    fi
}

# globstar: Available starting in Bash 4.0.
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
if [ ${BASH_VERSION:0:1} -gt 3 ]; then
    shopt -s globstar
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set editor.
if [[ -f /usr/bin/vim ]]; then
    # Path to Vim installed via apt.
    export EDITOR=/usr/bin/vim
    export VISUAL=/usr/bin/vim
elif [[ -f /usr/local/bin/vim  ]]; then
    # Path to Vim compiled from source.
    export EDITOR=/usr/local/bin/vim
    export VISUAL=/usr/local/bin/vim
elif [[ -f /usr/bin/vi ]]; then
    export EDITOR=/usr/bin/vi
    export VISUAL=/usr/bin/vi
fi

# Use vi keybindings.
set -o vi
bind -m vi-insert '"\C-p": previous-history'
bind -m vi-insert '"\C-n": next-history'
bind -m vi-insert '"\C-l": clear-screen'

# less options:
# -R: Output ANSI color escape sequences in raw form (for custom colors below)
# -X: Disable termcap initialization and deinitialization strings (so pager
#     display won't be cleared from screen on exit)
export LESS=-RX

# Set less colors, which result in colored man pages.
# Based on https://wiki.archlinux.org/index.php/Color_output_in_console#less
export GROFF_NO_SGR=1 # Required in certain terminal emulators.
export LESS_TERMCAP_mb=$'\E[1;34m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;34m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;34;34m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;37m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# GPG configuration
export GPG_TTY=$(tty)
export GPGKEY=838AA558

# virtualenvwrapper: The best way to set this up is to run
# "pip install --user virtualenv virtualenvwrapper". The next time you start
# a terminal emulator, you'll see some output from virtualenvwrapper.sh, and
# everything will work properly thereafter. Make sure that you do this with
# the version of pip that corresponds to your system's default version of
# Python; otherwise, you'll get an error.
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src

readonly VIRTUALENVWRAPPER="$HOME/.local/bin/virtualenvwrapper.sh"
if [[ -f "$VIRTUALENVWRAPPER" ]]; then
    source "$VIRTUALENVWRAPPER"
fi

# ls aliases
alias l='ls -CF'
alias la='ls -A'

# Linux, FreeBSD, and Darwin have the -b option, but OpenBSD doesn't.
# FreeBSD and Darwin have the -G option, but OpenBSD doesn't.
readonly os_name="$(uname)"
if [ "$os_name" = "OpenBSD" ]; then
    alias ll='ls -AhlF'
elif [ "$os_name" = "FreeBSD" ] || [ "$os_name" = "Darwin" ]; then
    alias ll='ls -AhlFbG'
else
    # Linux
    alias ll='ls -AhlFb'
fi

# Use color for lll on Linux.
if [ "$os_name" = "Linux" ]; then
    alias lll='ll --color=always | less -R'
else
    alias lll='ll | less'
fi

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Always start tmux in 256-color mode.
alias tmux='tmux -2'

# Always run lynx with the "textfields need activation" option (also
# configurable in lynx.cfg).
alias lynx='lynx -tna'

export GOPATH=$HOME/go

export PATH="$PATH:$HOME/bin:$GOPATH/bin"

export PYTHONPATH="$PATH:"

# Directories in which to search for Lynx config files (excluding .lynxrc,
# which must always be in the home directory)
export LYNX_CFG_PATH=~/.lynx:/etc/lynx:/etc

if [ -f ~/.lynx/lynx.cfg ]; then
    export LYNX_CFG=~/.lynx/lynx.cfg
fi
