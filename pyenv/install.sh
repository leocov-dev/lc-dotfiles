#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists "pyenv"; then
    pyenv_deps

    cascade_command brew \
        "brew install pyenv" \
        "brew install openssl readline sqlite3 xz zlib"
    cascade_command git \
        "git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv"
    if cascade_end; then
        log_error "Failed to install: pyenv"
    fi
else
    log_debug "Already installed: pyenv"
fi

if [[ -d "$HOME/.pyenv" ]]; then
    log_info "Updating pyenv"
    git_pull "$HOME/.pyenv"
fi

pyenv_deps() {
    cascade_command apt-get \
        "sudo -n apt-get -y install --no-install-recommends make
                                                            build-essential
                                                            libssl-dev
                                                            zlib1g-dev
                                                            libbz2-dev
                                                            libreadline-dev
                                                            libsqlite3-dev
                                                            wget
                                                            curl
                                                            llvm
                                                            libncurses5-dev
                                                            xz-utils
                                                            tk-dev
                                                            libxml2-dev
                                                            libxmlsec1-dev
                                                            libffi-dev
                                                            liblzma-dev"
    if cascade_end; then
        log_error "Failed to install pyenv dependencies"
    fi
}
