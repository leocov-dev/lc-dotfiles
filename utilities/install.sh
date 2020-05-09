#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

###########################
# Install micro text editor
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

#####################
# Install grc utility
if ! command_exists "grc"; then
    cascade_command brew \
        "brew install grc"
    cascade_command apt-get \
        "sudo -n apt-get -y install grc"
    if cascade_end; then
        log_error "Failed to install: grc"
    fi
else
    log_debug "Already installed: grc"
fi
