#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists tmux; then
    cascade_command brew \
        "brew install tmux"
    cascade_command apt-get \
        "sudo -n apt-get -y install tmux"
    if cascade_end; then
        log_error "Failed to install: tmux"
    fi

else
    log_debug "Already installed: tmux"
fi

if ! directory_exists "${HOME}/.tmux/plugins/tpm"; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! file_exists "${HOME}/.tmux.conf"; then
    ln -s "${DOTFILES}/tmux/tmux.conf" "${HOME}/.tmux.conf"
fi
