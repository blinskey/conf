readonly ALIASES=~/.zsh_aliases

# Powerline path when installed via "apt-get install powerline" in Ubuntu
readonly POWERLINE=/usr/share/powerline/bindings/zsh/powerline.zsh

# Path to zsh-syntax-highlighting plugin
readonly SYNTAX_HIGHLIGHTING=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# command-not-found zsh script
readonly COMMAND_NOT_FOUND=/etc/zsh_command_not_found

# Set editor.
if [[ -f /usr/bin/vim ]]; then
    export EDITOR=/usr/bin/vim
    export VISUAL=/usr/bin/vim
elif [[ -f /usr/bin/vi ]]; then
    export EDITOR=/usr/bin/vi
    export VISUAL=/usr/bin/vi
else
    echo ".zshrc: Failed to find vim or vi!" >&2
fi

# Load aliases.
if [ -f "$ALIASES" ]; then
    source "$ALIASES"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/blinskey/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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

# Enable fish-style syntax highlighting using the zsh-syntax-highlighting
# package from https://github.com/zsh-users/zsh-syntax-highlighting
source "$SYNTAX_HIGHLIGHTING"

# Automatic $PATH rehash:
setopt nohashdirs

# Remap Caps Lock to Ctrl in X11.
setxkbmap -option ctrl:nocaps &>/dev/null

# Enable command-not-found.
if [[ -f "$COMMAND_NOT_FOUND" ]]; then
  source "$COMMAND_NOT_FOUND"
fi

# Set prompt theme. If possible, enable Powerline prompt (package "powerline"
# in recent Ubuntu releases, or "powerline-status" in pip). Otherwise, use
# built-in prompt.
#
# See https://github.com/powerline/powerline and powerline.readthedocs.org
if [[ -f "$POWERLINE" ]]; then
    source "$POWERLINE"
else
    autoload -U promptinit && promptinit
    prompt redhat
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
