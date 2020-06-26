#!/usr/bin/env bash

set -e

# shellcheck source=./.utils/functions.sh
source "$DOTFILES/.utils/functions.sh"

log_warn "Installing: goenv - Not yet implemented..."

if [[ -d "$HOME/.goenv" ]]; then
    log_info "Updating goenv"
    git_pull "$HOME/.goenv"
fi
