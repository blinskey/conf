if [[ -f /usr/bin/vim ]]; then
    alias vi=vim
fi

alias l='ls -Ahlb'
alias ll=l
alias lll='ls -Ahlb --color=always | less -R'

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
