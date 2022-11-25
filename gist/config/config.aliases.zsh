#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# Shell
function reload_shell() {
  exec "${SHELL}" -l
  clear
}
alias reload!='reload_shell'
alias r!="reload!"

alias cl="clear"
alias ls="ls -GFp --color=auto"
alias ll="ls -lhA"

alias .zshrc='$EDITOR ~/.zshrc'

# ------------------------------------------------------------------------------
# codenv helpers
alias goenv-update='cd ${HOME}/.goenv && git pull'
alias pyenv-update='cd ${HOME}/.pyenv && git pull'
alias nodenv-update='nodenv update-version-defs'

# ------------------------------------------------------------------------------
# git
alias gpl='git pull --prune --recurse-submodules'
alias ga='git add -A && git status -sb'
alias gc='git commit -m'
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
ecr_login() {
    aws ecr get-login-password \
        --region us-east-2 \
        --profile ecr-dev \
        | docker login \
            -u AWS \
            --password-stdin "https://${ECR}"
}

ecr_create_repo() {
    local __repo_name=${1}

    if [[ -z $__repo_name ]]; then
        echo "Error: must supply repo name"
        return 1
    fi

    aws ecr create-repository \
        --repository-name homelab/${__repo_name} \
        --profile ecr-dev
}
alias ecr-login='ecr_login'
alias ecr-create-repo='ecr_create_repo'

# ------------------------------------------------------------------------------
# helpers
gen_token() {
  python -c "import secrets; print(secrets.token_urlsafe(${1:-32}))"
}
alias gen-token='gen_token'
