#!/usr/bin/env bash

source "${DOTFILES}/.utils/functions.sh"

#alias reload!='exec "$SHELL" -l'
alias reload!='source ~/.zshrc'
alias reinstall!='$DOTFILES/bin/install'
alias zshrc='$EDITOR ~/.zshrc'

alias ..='cd ..'
alias cl="clear"

alias ls='ls --color --classify'
alias ll="ls -l --human-readable --almost-all"

alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mt"

if [[ ! $(os_type) == "darwin" ]]; then
    alias open="xdg-open 2>/dev/null"
fi

gh-open() {
    file=${1:-""}
    git_branch=${2:-$(git symbolic-ref --quiet --short HEAD)}
    git_project_root=$(git config remote.origin.url | sed "s~git@\(.*\):\(.*\)~https://\1/\2~" | sed "s~\(.*\).git\$~\1~")
    git_directory=$(git rev-parse --show-prefix)
    open ${git_project_root}/tree/${git_branch}/${git_directory}${file} &>/dev/null
}

alias gh=gh-open
