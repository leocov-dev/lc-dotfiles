#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# GOENV
if [[ ! -d "${HOME}/.goenv" ]]; then
  echo "Setup GOENV"
  git clone https://github.com/syndbg/goenv.git "${HOME}/.goenv"
fi

# ------------------------------------------------------------------------------
# PYENV
if [[ ! -d "${HOME}/.pyenv" ]]; then
  echo "Setup PYENV"
  git clone https://github.com/pyenv/pyenv.git "${HOME}/.pyenv"
  git clone https://github.com/s1341/pyenv-alias.git "${HOME}/.pyenv/plugins/pyenv-alias"
fi

# ------------------------------------------------------------------------------
# NODENV
if [[ ! -d "${HOME}/.nodenv" ]]; then
  echo "Setup NODENV"
  git clone https://github.com/nodenv/nodenv.git "${HOME}/.nodenv"
  mkdir "${HOME}/.nodenv/plugins"
  git clone https://github.com/nodenv/node-build.git "${HOME}/.nodenv/plugins/node-build"
  git clone https://github.com/nodenv/node-build-update-defs.git "${HOME}/.nodenv/plugins/node-build-update-defs"
fi
