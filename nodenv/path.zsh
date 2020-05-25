#!/usr/bin/env bash

# NODE
export NODENV_ROOT="$HOME/.nodenv"

if [[ -d "$NODENV_ROOT" ]]; then
    log_debug "Loading 'nodenv' from $NODENV_ROOT"
    export PATH="$NODENV_ROOT/bin:$PATH"
    eval "$(nodenv init -)"
else
    log_warn "Failed to find: $NODENV_ROOT"
fi
