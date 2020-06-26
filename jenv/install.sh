#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists "jenv"; then
    cascade_command brew \
        "brew install jenv"
    cascade_command git \
        "git clone https://github.com/jenv/jenv.git $HOME/.jenv"
    if cascade_end; then
        log_error "Failed to install: jenv"
    fi

    export PATH="$JENV_ROOT/bin:$PATH"
    eval "$(jenv init -)"
    jenv enable-plugin export
else
    log_debug "Already installed: jenv"
fi

if [[ -d "$HOME/.jenv" ]]; then
    log_info "Updating jenv"
    git_pull "$HOME/.jenv"
fi
