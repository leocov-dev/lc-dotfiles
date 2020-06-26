#!/usr/bin/env bash

set -e

# shellcheck source=./.utils/functions.sh
source "$DOTFILES/.utils/functions.sh"

log_warn "Installing: nodenv - Not yet implemented..."

if [[ -d "$HOME/.nodenv" ]]; then
    log_info "Updating nodenv"
    git_pull "$HOME/.nodenv"
fi
