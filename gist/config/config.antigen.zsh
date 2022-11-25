#!/usr/bin/env zsh

_antigen_script="${HOME}/.local/shell/antigen.zsh"

if [[ ! -f "${_antigen_script}" ]]; then
    echo "antigen not found, installing now to: ${_antigen_script}"
    curl -L git.io/antigen >"${_antigen_script}"
fi

# ------------------------------------------------------------------------------
source "${_antigen_script}"

# ------------------------------------------------------------------------------
# plugins to install
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-completions

antigen apply

# ------------------------------------------------------------------------------
# configure zsh-history-substring-search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "${terminfo}[kcuu1]" history-substring-search-up
bindkey "${terminfo}[kcud1]" history-substring-search-down
