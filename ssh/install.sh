#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

if file_exists "${HOME}/.ssh/config"; then
    # file is a symlink
    realFilePath=$(realpath "${HOME}/.ssh/config")
    if [[ "${DOTFILES}/ssh/config" != "$realFilePath" ]]; then
        log_info "Moved existing .ssh/config to .ssh/config.local"
        mv "${HOME}/.ssh/config" "${HOME}/.ssh/config.local"
        ln -s "${DOTFILES}/ssh/config" "${HOME}/.ssh/config"
    fi
else
    ln -s "${DOTFILES}/ssh/config" "${HOME}/.ssh/config"
fi

touch "${HOME}/.ssh/config.local"

# TODO if /media subdir has a keys archive open it and extract ssh keys
