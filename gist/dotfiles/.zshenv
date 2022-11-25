#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# path
export PATH="${PATH}:${HOME}/.local/bin"

# ------------------------------------------------------------------------------
# homebrew
HOMEBREW_ROOT_AM1="/opt/homebrew"
HOMEBREW_ROOT_X86="/usr/local"
if [[ -f "${HOMEBREW_ROOT_AM1}/bin/brew" ]]; then
  export HOMEBREW_ROOT="${HOMEBREW_ROOT_AM1}"
elif [[ -f "${HOMEBREW_ROOT_X86}/bin/brew" ]]; then
  export HOMEBREW_ROOT="${HOMEBREW_ROOT_X86}"
else
  echo "Can't find homebrew binary"
fi

export PATH="${HOMEBREW_ROOT}/bin:$PATH"
export PATH="${HOMEBREW_ROOT}/opt/coreutils/libexec/gnubin:${PATH}"

export HOMEBREW_NO_ENV_HINTS=true

# ------------------------------------------------------------------------------

source "${HOME}/.local/shell/config.env.zsh"
