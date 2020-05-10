#!/usr/bin/env bash

# shellcheck source=./.utils/functions.sh
source "$DOTFILES/.utils/functions.sh"

git_config_contains() {
    while IFS='=' read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "$2" ]]; then
            return 0
        fi
    done < <(git config --global --get-all "$1");

    return 1
}

if git_config_contains 'include.path' "$DOTFILES/git/gitconfig"; then
    echo "Found some poop"
else
    echo "Found no poop"
fi

# better diffs
if command_exists diff-so-fancy; then
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

    git config --global color.diff-highlight.oldNormal "red bold"
    git config --global color.diff-highlight.oldHighlight "red bold 52"
    git config --global color.diff-highlight.newNormal "green bold"
    git config --global color.diff-highlight.newHighlight "green bold 22"

    git config --global color.diff.meta "11"
    git config --global color.diff.frag "magenta bold"
    git config --global color.diff.commit "yellow bold"
    git config --global color.diff.old "red bold"
    git config --global color.diff.new "green bold"
    git config --global color.diff.whitespace "red reverse"
fi
