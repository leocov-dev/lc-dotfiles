#!/usr/bin/env bash

set -e

# shellcheck source=../.utils/functions.sh
source "${DOTFILES}/.utils/functions.sh"

ESP_IDF_ROOT="${HOME}/.esp/esp-idf"

if ! directory_exists "${HOME}/.esp/esp-idf"; then
    cascade_command git \
        "git clone -b v4.2 --recursive https://github.com/espressif/esp-idf.git $ESP_IDF_ROOT" \
        "$ESP_IDF_ROOT/tools/idf_tools.py install"
    if cascade_end; then
        log_error "Failed to install: esp-idf"
    fi
else
    log_debug "Already installed: esp-idf"
fi
