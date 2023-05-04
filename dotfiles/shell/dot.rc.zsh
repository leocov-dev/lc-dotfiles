#!/usr/bin/env/ zsh

# ------------------------------------------------------------------------------
# activate homebrew
eval $("${HOMEBREW_ROOT}/bin/brew" shellenv)

# ------------------------------------------------------------------------------
# zsh shell config
# shellcheck source=./config.zshopts.zsh
source "${HOME}/.local/shell/config.zshopts.zsh"

# default text editor
export MICRO_CONFIG_HOME="${HOME}/.micro/config"
export EDITOR='micro'
export VEDITOR='edit'

# shell colors
# shellcheck source=./config.lscolors.zsh
source "${HOME}/.local/shell/config.lscolors.zsh"

# antigen zsh plugins
# shellcheck source=./config.antigen.zsh
source "${HOME}/.local/shell/config.antigen.zsh"

# alias definitions
# shellcheck source=./config.aliases.zsh
source "${HOME}/.local/shell/config.aliases.zsh"

# code env (pyenv, goenv, nodenv, etc.)
# shellcheck source=./config.codenv.zsh
source "${HOME}/.local/shell/config.codenv.zsh"
