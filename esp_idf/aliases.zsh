#!/usr/bin/env bash

# shellcheck source=../.utils/functions
source "${DOTFILES}/.utils/functions.sh"

if file_exists "$HOME/.esp/esp-idf/export.sh"; then
    alias get_idf='. $HOME/.esp/esp-idf/export.sh'
    alias idf="idf.py -p /dev/ttyUSB0 -b 921600"
fi
