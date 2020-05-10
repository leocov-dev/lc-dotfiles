#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists "zsh"; then
    cascade_command brew \
        "brew install zsh"
    cascade_command apt \
        "sudo -n apt install zsh"
    if cascade_end; then
        log_fatal "Failed to install: zsh"
        exit 1
    fi
else
    log_debug "Already installed: zsh"
fi

if ! file_exists "${HOME}/.zshrc"; then
    # shellcheck disable=SC2088
    log_info "~/.zshrc not found, creating one..."

    cat <<\EOT > "${HOME}/.zshrc"
#!/usr/bin/env zsh

export DOTFILES_LOG_LEVEL=info

## LOAD DOTFILE CUSTOMIZATIONS
if [[ -f "$HOME/.dotfiles/zsh/zshrc" ]]; then
    source "$HOME/.dotfiles/zsh/zshrc"
fi

## ADD ADDITIONAL CUSTOMIZATIONS AFTER THIS LINE

EOT
fi
