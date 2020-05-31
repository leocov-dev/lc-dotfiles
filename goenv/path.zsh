#!/usr/bin/env bash

# GOLANG
export GOENV_ROOT="$HOME/.goenv"

if [[ -d "$GOENV_ROOT" ]]; then
    log_debug "Loading 'goenv' from $GOENV_ROOT"

    export PATH="$GOENV_ROOT/bin:$PATH"

#    GOENV_VERSION=$(goenv versions --bare | tail -n1)
#    export GOENV_VERSION

    eval "$(goenv init -)"

    export PATH="$GOROOT/bin:$PATH"
    # export PATH="$PATH:$GOENV_GOPATH_PREFIX/bin"
    # export GOPATH="$HOME/go/$GOENV_VERSION"
    export PATH="$PATH:$GOPATH/bin"
else
    log_warn "Failed to find: $GOENV_ROOT"
fi
