#!/usr/bin/env bash

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists "pyenv"; then
    cascade_command brew \
        "brew update" \
        "brew install pyenv" \
        "brew install openssl readline sqlite3 xz zlib"
    cascade_command git \
        "git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv"
    cascade_command apt-get \
        "sudo -n apt-get update" \
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
        log_error "Failed to install: pyenv"
    fi
else
    log_debug "Already installed: pyenv"
fi

log_info "Updating pyenv"
git_pull "$HOME/.pyenv"
