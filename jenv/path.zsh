#!/usr/bin/env bash

# NODE
export JENV_ROOT="$HOME/.jenv"

if [[ -d "$JENV_ROOT" ]]; then
    log_debug "Loading 'jenv' from $JENV_ROOT"
    export PATH="$JENV_ROOT/bin:$PATH"
    eval "$(jenv init -)"
else
    log_warn "Failed to find: $JENV_ROOT"
fi
