#!/usr/bin/env bash

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

cascade_command apt \
    "sudo -n apt-get install xdotool"
cascade_end

cascade_command apt \
    "sudo -n apt-get install wmctrl"
cascade_end
