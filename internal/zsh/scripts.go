package zsh

var ZshShBang = `#!/usr/bin/env zsh`

var HomebrewInit = `
# activate homebrew
eval $("${HOMEBREW_ROOT}/bin/brew" shellenv)
`

var ZshRc = `
# zsh shell config
source "${HOME}/.local/shell/config.shell.zsh"

# default text editor
export MICRO_CONFIG_HOME="${HOME}/.micro/config"
export EDITOR='micro'
export VEDITOR='edit'

# shell colors
source "${HOME}/.local/shell/config.lscolors.zsh"

# antigen zsh plugins
source "${HOME}/.local/shell/config.antigen.zsh"

# shell alias definitions
source "${HOME}/.local/shell/config.aliases.zsh"

# code env (pyenv, goenv, nodenv, etc.)
source "${HOME}/.local/shell/config.codenv.zsh"

# ------------------------------------------------------------------------------
# MUST BE LAST
# starship shell prompt
eval "$(starship init zsh)"
`
