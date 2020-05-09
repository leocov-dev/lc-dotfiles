#!/usr/bin/env bash

# GOLANG
export GOENV_ROOT="$HOME/.goenv"

if [[ -d GOENV_ROOT ]]; then
    export PATH="$GOENV_ROOT/bin:$PATH"

    GOENV_VERSION=$(goenv versions --bare | tail -n1)
    export GOENV_VERSION

    eval "$(goenv init -)"

    export PATH="$GOROOT/bin:$PATH"
    # export PATH="$PATH:$GOENV_GOPATH_PREFIX/bin"
    # export GOPATH="$HOME/go/$GOENV_VERSION"
    export PATH="$PATH:$GOPATH/bin"
fi
