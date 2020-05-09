#!/usr/bin/env bash

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

alias gas="git add -u && git status -s"
