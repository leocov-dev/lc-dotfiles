#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

if command_exists git; then
    if [[ -d "$HOME/.config/base16-shell" ]]; then
        log_info 'base16-shell already installed'
    else
        git clone https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell"
    fi
fi
