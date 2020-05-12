#!/usr/bin/env bash

# setup solarized ls colors
if [[ ! -f $HOME/.zsh-dircolors.config ]]; then
    log_info 'Initialized plugin: zsh-dircolors'
    setupsolarized dircolors.ansi-dark  # TODO this does not work on MACOS, no `dircolors`
fi
