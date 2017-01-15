# Path to zsh-syntax-highlighting plugin. This is the path where the plugin is
# installed by the Debian and RPM zsh-syntax-highlighting packages. Source
# available from https://github.com/zsh-users/zsh-syntax-highlighting
readonly SYNTAX_HIGHLIGHTING=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ubuntu command-not-found zsh script
readonly COMMAND_NOT_FOUND=/etc/zsh_command_not_found

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
else
    echo ".zshrc: Failed to find vim or vi!" >&2
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
zstyle :compinstall filename '/home/blinskey/.zshrc'

autoload -Uz compinit
compinit

# Enable Vim mode.
bindkey -v

# Reduce delay when switching from insert mode to normal mode to 10 ms.
export KEYTIMEOUT=1

# Set Vim CLI commands.
bindkey '^P' up-history
bindkey '^N' down-history

# Enable backspace and ^H after switching from normal mode to insert mode.
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# Enable history search.
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward

# Key settings copied from Arch Linux wiki:

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# End key settings from ArchWiki.

# Ignore duplicate lines in history.
setopt HIST_IGNORE_DUPS

# Automatic $PATH rehash:
setopt nohashdirs

# Remap Caps Lock to Ctrl in X11.
setxkbmap -option ctrl:nocaps &>/dev/null

# Enable command-not-found.
if [[ -f "$COMMAND_NOT_FOUND" ]]; then
  source "$COMMAND_NOT_FOUND"
fi

# Color man pages using less.
# From https://wiki.archlinux.org/index.php/Man_page#Colored_man_pages
man() {
        env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

# Enable "help" command.
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
alias help=run-help

# To load built-in prompts and use the "redhat" prompt, uncomment
# the following lines.
#autoload -U promptinit && promptinit
#prompt redhat

# Set custom prompt. The left prompt is similar to the built-in "redhat" prompt
# and uses a bit of color to make the prompt stand out and improve readability.
# The right prompt displays the exit code returned by the previous command,
# colored green if zero or red otherwise.
autoload -U colors && colors
PROMPT="[%{$fg_bold[blue]%}%n%{$reset_color%}@%{$fg_bold[blue]%}%m%{$reset_color%}:%{$fg_bold[blue]%}%3~%{$reset_color%}]%(#.#.$) "
PS2="> "
RPROMPT=[%(0?.%{$fg[green]%}0.%{$fg_bold[red]%}%?)%{$reset_color%}]

# Enable syntax highlighting if plugin exists.
if [[ -f "$SYNTAX_HIGHLIGHTING" ]]; then
    source "$SYNTAX_HIGHLIGHTING"
fi

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

### Aliases ###################################################################

# ls aliases
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

# Always run lynx with the "textfields need activation" option (also
# configurable in lynx.cfg).
alias lynx='lynx -tna'
