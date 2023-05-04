#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# Shell
reload_shell() {
  exec "${SHELL}" -l
}
alias reload!='reload_shell && clear'
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
alias token='gen_token'

gpg_scan() {
    gpg-connect-agent "scd serialno" "learn --force" /bye >/dev/null
    gpg -K >/dev/null
}
alias gpg-scan="gpg_scan"
alias gpgscan="gpg_scan"

# ------------------------------------------------------------------------------
# python helpers

fuzzy_source_venv() {
  # find the first `venv` like named directory in the current dir and activate it

  local _list=()
  local _current_dir
  _current_dir="$(pwd)"

  IFS=$'\n' read -d '' -r -a _list <<< "$(find "$_current_dir" -maxdepth 1 -type d | grep venv)"

  if [[ ${#_list[@]} -lt 1 ]]; then
  echo "Failed to activate venv, none found in: \"$_current_dir\"" >&2
  exit 1
else
  echo "==> activating venv: \"${_list[0]}\""
  echo
  # shellcheck disable=SC1090
  source "${_list[0]}/bin/activate"
fi
}

alias venvpython='fuzzy_source_venv && python'
