#!/usr/bin/env bash

# shellcheck source=./.utils/functions.sh
source "$DOTFILES/.utils/functions.sh"

log_warn "Not yet implemented..."

log_info "Updating nodenv"
git_pull "$HOME/.nodenv"