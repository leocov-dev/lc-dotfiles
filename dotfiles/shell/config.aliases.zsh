#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# Shell
alias reload!='lc_reload_shell'
alias r!="reload!"

alias cl="clear"
alias ls="ls -GFp --color=auto"
alias ll="ls -lhA"

alias .zshrc='$EDITOR ~/.zshrc'

# ------------------------------------------------------------------------------
# brew
alias brew86="arch -x86_64 /usr/local/bin/brew"

# ------------------------------------------------------------------------------
# codenv helpers
alias goenv-update='cd ${HOME}/.goenv && git pull'
alias pyenv-update='cd ${HOME}/.pyenv && git pull'
alias nodenv-update='nodenv update-version-defs'

# ------------------------------------------------------------------------------
# git
alias gpl='git pull --prune --recurse-submodules'
alias ga='git add -A && git status -sb'
alias gc='gpg-scan && git commit -m'
alias gs='git status -sb'

# ------------------------------------------------------------------------------
# kubernetes
alias kc='kubectl'
alias helm3='helm'

# ------------------------------------------------------------------------------
# docker
alias dk="docker"
alias dc="docker-compose"
alias lzd="lazydocker"

# ------------------------------------------------------------------------------
# aws
alias ecr-login='lc_ecr_login'
alias ecr-create-repo='lc_ecr_create_repo'

# ------------------------------------------------------------------------------
# helpers
alias gen-token='lc_gen_token'
alias token='gen-token'

alias gpg-scan="lc_gpg_scan"
alias gpgscan="gpg-scan"

# ------------------------------------------------------------------------------
# python helpers

alias venvpython='lc_venv_python'
