#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

must_sudo

if ! command_exists "dart"; then
    cascade_command brew \
        "brew tap dart-lang/dart" \
        "brew install dart"
    cascade_command apt \
        "sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'" \
        "sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'" \
        "sudo apt -y install dart"
    if cascade_end; then
        log_error "Failed to install: dart"
    fi
else
    log_debug "Already installed: dart"
fi
