#!/bin/sh

alias reload!='exec "$SHELL" -l'

alias ..='cd ..'

alias ls='ls --color --classify'
alias ll="ls -l --human-readable --almost-all"

alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mt"

alias cl="clear"
alias zshconfig="subl ~/.zshrc"
alias gas="git add -u && git status -s"
