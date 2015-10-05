#!/bin/bash
#
# Minimal system setup script. Requires an Internet connection and a recent
# version of Ubuntu. Setup can be customized using various files in the same
# directory as this file.
#
# TODO:
# - Check specific OS name and version and adjust actions accordingly.
# - Support other types of systems.
# - Support older verrsions of Ubuntu: install Powerline from pip and symlink.

set -e
set -u
set -o pipefail

readonly DIR="$(dirname "$(readlink -f "$0")")"
readonly PACKAGES="${DIR}/packages"
readonly DOTFILES="${DIR}/dotfiles"
readonly CODE_DIR="${HOME}/code"

main() {
    require_sudo
    check_os
    install_packages
    install_dotfiles
    configure

    printf "Done.\n"
    exit 0
}

require_sudo() {
    if [[ $(id -u) != 0 ]]; then
	printf "This script must be run as root.\n" >&2
	exit 1
    fi
}

check_os() {
    if ! grep -qi 'ID_LIKE=debian' /etc/os-release; then
	printf "This script is only compatible with Debian-like systems.\n" >&2
	exit 1
    fi
}

install_packages() {
    printf "Installing packages via apt...\n"
    # We want the list of packages to be split into words.
    # shellcheck disable=SC2046
    apt-get install -y $(paste -sd' ' "$PACKAGES")
}

install_dotfiles() {
    printf "Linking dotfiles...\n"
    while read file; do
	ln -sf "${DIR}/${file}" ~
    done <"$DOTFILES"

    install_xfce4_terminalrc
}

configure() {
    printf "Setting shell to zsh...\n"
    chsh -s "$(which zsh)" "$(logname)"

    printf "Installing zsh-syntax-highlighting plugin...\n"
    install_zsh_syntax_highlighting

    printf "Installing Powerline fonts...\n"
    install_powerline_fonts
}

install_zsh_syntax_highlighting() {
    local repo="zsh-users/zsh-syntax-highlighting"
    local target="${CODE_DIR}/zsh-syntax-highlighting"
    clone_from_github "$repo" "$target"

    mkdir -p "/usr/share/zsh/plugins"
    ln -s "$target" "/usr/share/zsh/plugins"
}

install_powerline_fonts() {
    local repo="powerline/fonts"
    local target="${CODE_DIR}/powerline_fonts"
    clone_from_github "$repo" "$target"

    "${target}/install.sh"
}

# Clones the specified repository to the given target directory. If a directory
# already exists at this path, it will be removed.
#
# $1: repository ID in the form "<user>/<repo>", e.g. "blinskey/config-files"
# $2: target directory name
clone_from_github() {
    local repo_id=$1
    local target=$2

    mkdir -p "$target"
    local repo_url=https://github.com/${repo_id}.git
    git clone "$repo_url" "$target"
}

install_xfce4_terminalrc() {
    ln -sf "${DIR}/terminalrc" "${HOME}/.config/xfce4/terminal/terminalrc"
}

main
