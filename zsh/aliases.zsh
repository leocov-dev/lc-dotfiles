#!/usr/bin/env bash

# shellcheck source=../.utils/functions
source "${DOTFILES}/.utils/functions.sh"

 alias reload!='exec "$SHELL" -l'
#alias reload!='source ~/.zshrc'
alias bootstrap!='$DOTFILES/.bin/bootstrap'
alias .zshrc='$EDITOR ~/.zshrc'
alias .dotfiles='cd $DOTFILES'
alias .dotfiles.env='$EDITOR $DOTFILES'

alias cl="clear"

alias ls="ls -Fp --color=auto"
alias ll="ls -lhA"

alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mt"

if [[ ! $(os_type) == "darwin" ]]; then
    alias open="xdg-open 2>/dev/null"
    alias edit="atom"
else
    alias edit="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
fi

gh-open() {
    file=${1:-""}
    git_branch=${2:-$(git symbolic-ref --quiet --short HEAD)}
    git_project_root=$(git config remote.origin.url | sed "s~git@\(.*\):\(.*\)~https://\1/\2~" | sed "s~\(.*\).git\$~\1~")
    git_directory=$(git rev-parse --show-prefix)
    open ${git_project_root}/tree/${git_branch}/${git_directory}${file} &>/dev/null
}

alias gh=gh-open

workon_alias() {
  local workonRoot="$1"

  if [ -n "$workonRoot" ] && [ -d "$workonRoot" ]; then
    # change directories
    pushd "$workonRoot" > /dev/null || return;
    for project in $(find . -maxdepth 1 -mindepth 1 -type d | sed 's/^.\///'); do
        root=$(basename "$workonRoot")
      alias $root-$project="cd $workonRoot/$project";
    done
    # return the previous directory
    popd > /dev/null || return;
  fi
}

workon_alias "$HOME/src"
workon_alias "$HOME/repos"
