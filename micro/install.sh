#!/usr/bin/env bash

set -e

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


install_update_plugin() {
    if ! micro -plugin update $1; then
        micro -plugin install $1
    fi
}

install_update_plugin filemanager
install_update_plugin manipulator
