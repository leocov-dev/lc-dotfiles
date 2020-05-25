#!/usr/bin/env bash

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

# PYTHON
export PYENV_ROOT="$HOME/.pyenv"

if [[ -d "$PYENV_ROOT" ]]; then
    log_debug "Loading 'pyenv' from $PYENV_ROOT"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
else
    log_warn "Failed to find: $PYENV_ROOT"
fi
