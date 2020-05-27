#!/usr/bin/env bash

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
else
    log_debug "Already installed: alacritty"
fi

if ! file_exists "${HOME}/.alacritty.yml"; then
    ln -s "${DOTFILES}/alacritty/alacritty.yml" "${HOME}/.alacritty.yml"
fi
