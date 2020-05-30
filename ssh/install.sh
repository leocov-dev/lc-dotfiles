#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"


# TODO this could use some work...
#if file_exists "${HOME}/.ssh/config"; then
#
#    realFilePath=$(realpath "${HOME}/.ssh/config")
#
#    if [[ "${DOTFILES}/ssh/config" != "$realFilePath" ]]; then
#        if mv "${HOME}/.ssh/config" "${HOME}/.ssh/config.local"; then
#            log_info "Moved existing .ssh/config to .ssh/config.local"
#
#            ln -s "${DOTFILES}/ssh/config" "${HOME}/.ssh/config"
#        else
#            log_error "Failed to move existing ssh config file."
#        fi
#    fi
#else
#    ln -s "${DOTFILES}/ssh/config" "${HOME}/.ssh/config"
#fi
#
#touch "${HOME}/.ssh/config.local"

# TODO if /media subdir has a keys archive open it and extract ssh keys
