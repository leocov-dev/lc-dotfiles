#!/bin/zsh

if [[ -x $(command -v setupsolarized &> /dev/null) ]]; then
    setupsolarized dircolors.ansi-dark
fi
