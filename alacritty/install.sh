#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists alacritty; then
    cascade_command brew \
        "brew cask install alacritty"
    cascade_command apt-get \
        "sudo -n add-apt-repository ppa:mmstick76/alacritty" \
        "sudo -n apt-get -y install alacritty"
    if cascade_end; then
        log_error "Failed to install: alacritty"
    fi

    git clone git@github.com:aaron-williamson/base16-alacritty.git "$HOME/.config/base16-alacritty"

else
    log_debug "Already installed: alacritty"
fi

if ! file_exists "${HOME}/.alacritty.yml"; then
    ln -s "${DOTFILES}/alacritty/alacritty.yml" "${HOME}/.alacritty.yml"
fi
