#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# PYTHON
export PYENV_ROOT="$HOME/.pyenv"

if [[ -d "$PYENV_ROOT" ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# ------------------------------------------------------------------------------
# NODE
export NODENV_ROOT="$HOME/.nodenv"

if [[ -d "$NODENV_ROOT" ]]; then
    export PATH="$NODENV_ROOT/bin:$PATH"
    eval "$(nodenv init -)"
fi

# ------------------------------------------------------------------------------
# GOLANG
export GOENV_ROOT="$HOME/.goenv"

if [[ -d "$GOENV_ROOT" ]]; then
    export PATH="$GOENV_ROOT/bin:$PATH"

    eval "$(goenv init -)"

    export PATH="$PATH:$GOPATH/bin"
fi
