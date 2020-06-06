#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists "atom"; then
    cascade_command brew \
        "brew install atom"  # TODO not confirmed
    cascade_command curl \
        "wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -" \
        "sudo -n sh -c 'echo \"deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main\" > /etc/apt/sources.list.d/atom.list'" \
        "sudo -n apt-get update" \
        "sudo -n apt-get install atom"
    if cascade_end; then
        log_error "Failed to install: atom"
    fi
else
    log_debug "Already installed: atom"
fi
