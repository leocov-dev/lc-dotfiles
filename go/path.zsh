#!/bin/zsh

# GOLANG
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export GOENV_VERSION=$(goenv versions --bare | tail -n1)
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
# export PATH="$PATH:$GOENV_GOPATH_PREFIX/bin"
# export GOPATH="$HOME/go/$GOENV_VERSION"
export PATH="$PATH:$GOPATH/bin"
