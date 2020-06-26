#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

cascade_command apt \
    "sudo -n apt-get -y install xdotool"
if cascade_end; then
    log_error 'Failed to install xdotool'
fi

cascade_command apt \
    "sudo -n apt-get -y install wmctrl"
if cascade_end; then
    log_error 'Failed to install wmctrl'
fi
