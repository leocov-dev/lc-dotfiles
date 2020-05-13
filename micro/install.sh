#!/usr/bin/env bash

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists "micro"; then
    cascade_command brew \
        "brew install micro"
    cascade_command curl \
        "curl https://getmic.ro | bash" \
        "sudo -n mv \"./micro\" \"/usr/local/bin/micro\""
    if cascade_end; then
        log_error "Failed to install: micro"
    fi
else
    log_debug "Already installed: micro"
fi