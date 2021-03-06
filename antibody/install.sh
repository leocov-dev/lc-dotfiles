#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists "antibody"; then
    cascade_command brew \
        "brew tap | grep -q 'getantibody/tap' || brew tap getantibody/tap" \
        "brew install antibody"
    cascade_command curl \
        "curl -sfL git.io/antibody | sudo -n sh -s - -b /usr/local/bin"
    if cascade_end; then
        log_error "Failed to install: antibody"
    fi
else
    log_debug "Already installed: antibody"
fi

antibodyHome="$(antibody home)"

if [[ -d "$antibodyHome" ]]; then
    rm -rf "$antibodyHome"
fi

antibody bundle < "$DOTFILES/antibody/bundles.txt" > "$HOME/.zsh_plugins.sh"
antibody update > /dev/null
