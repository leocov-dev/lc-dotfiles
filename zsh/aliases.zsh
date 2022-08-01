#!/usr/bin/env bash

# shellcheck source=../.utils/functions
source "${DOTFILES}/.utils/functions.sh"

 alias reload!='exec "$SHELL" -l'
#alias reload!='source ~/.zshrc'
alias bootstrap!='$DOTFILES/.bin/bootstrap'
alias .zshrc='$EDITOR ~/.zshrc'
alias .dotfiles='cd $DOTFILES'
alias .dotfiles.env='$EDITOR $DOTFILES'

alias colima-start='colima start --cpu 2 --memory 10 --disk 128'

alias cl="clear"

alias ls="ls -Fp --color=auto"
alias ll="ls -lhA"

alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mt"

alias lzd="lazydocker"

if [[ ! $(os_type) == "darwin" ]]; then
    alias open="xdg-open 2>/dev/null"
    alias edit="atom"
else
    alias edit="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
fi

docker_image_rm() {
	local regex=${1:-"^$"}

	if [[ ${regex} == "--help" ]]; then
		echo "Usage: docker_image_rm <a_grep_valid_regex>"
		echo "       - if regex uses symbols/character you must"
		echo "         quote to prevent them from being interpreted"
		echo "         by the shell"
	else
		local containers=$(docker image ls --format "{{.Repository}}\t{{.ID}}" | grep "${regex}")

		if [[ ${containers} == "" ]]; then
			echo "Nothing matched to remove"
		else
			echo "Removing:"
			local container_names=$(echo "${containers}" | awk '{print $1}')
			local container_ids=$(echo "${containers}" | awk 'BEGIN {ORS=" "} {print $2}')
			echo ${container_names}
			docker image rm ${container_ids}
		fi
	fi	
}

gh-open() {
    local file=${1:-""}
    local git_branch=${2:-$(git symbolic-ref --quiet --short HEAD)}
    local git_project_root=$(git config remote.origin.url | sed "s~git@\(.*\):\(.*\)~https://\1/\2~" | sed "s~\(.*\).git\$~\1~")
    local git_directory=$(git rev-parse --show-prefix)
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
