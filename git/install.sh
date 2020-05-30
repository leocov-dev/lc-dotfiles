#!/usr/bin/env bash

# shellcheck source=./.utils/functions.sh
source "$DOTFILES/.utils/functions.sh"

must_sudo

if ! command_exists "git"; then
    cascade_command brew \
        "brew install git"
    cascade_command apt-get \
        "sudo -n apt-get install git-all"
    if cascade_end; then
        log_error "Failed to install: git"
    fi
else
    log_debug "Already installed: git"
fi

git_setup_user

if ! git_config_is_set "alias.up"; then
    git config --global alias.up '!git remote update -p; git merge --ff-only @{u}'
fi

if ! git_config_contains 'include.path' "$DOTFILES/git/gitconfig"; then
    git config --global --add include.path "$DOTFILES/git/gitconfig"
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
