#!/bin/bash
#
# A script that can be used to set up a system by installing Git, cloning the
# config-files repo, and running install.sh. Requires an Internet connection
# and a recent version of Ubuntu. The config-files repository must not already
# exist in $REPO_DIR.

set -e
set -u
set -o pipefail

readonly CODE_DIR="${HOME}/code"
readonly REPO="https://github.com/blinskey/config-files.git"
readonly REPO_DIR="${CODE_DIR}/config-files"

main() {
    require_sudo
    check_os

    apt-get install -y git

    mkdir -p "${HOME}/code"
    pushd "$CODE_DIR" &>/dev/null
    git clone "$REPO" "$REPO_DIR"
    pushd "$REPO_DIR" &>/dev/null
    ./install.sh
    popd &>/dev/null
    popd &>/dev/null
}

require_sudo() {
    if [[ $(id -u) != 0 ]]; then
	printf "This script must be run as root.\n" >&2
	exit 1
    fi
}

check_os() {
    if ! grep -i 'ID_LIKE=debian' /etc/os-release; then
	printf "This script is only compatible with Debian-like systems.\n" >&2
	exit 1
    fi
}

main
