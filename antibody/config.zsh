#!/bin/zsh

# setup solarized ls colors
if [[ ! -f $HOME/.zsh-dircolors.config ]]; then
    echo 'setup zsh-dircolors'
    setupsolarized dircolors.ansi-dark
fi
