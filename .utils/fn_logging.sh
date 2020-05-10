#!/usr/bin/env bash

# shellcheck source=./fn_colors.sh
source "$DOTFILES/.utils/fn_colors.sh"

debug=1
info=2
warn=3
error=4

global_log_level=$info

log_levels=(
    [debug]=$debug
    [$debug]=debug
    [info]=$info
    [$info]=info
    [warn]=$warn
    [$warn]=warn
    [error]=$error
    [$error]=error
)

if [[ -n $DOTFILES_LOG_LEVEL ]]; then
    global_log_level=${log_levels[${DOTFILES_LOG_LEVEL:l}]}
fi

log_debug() {
    if [[ $global_log_level -le $debug ]]; then
        echo -e "${c_grey}[DEBUG]${c_reset} $*"
    fi
}

log_info() {
    if [[ $global_log_level -le $info ]]; then
        echo -e "${c_blue}[INFO ]${c_reset} $*"
    fi
}

log_warn() {
    if [[ $global_log_level -le $warn ]]; then
        echo -e "${c_yellow}[WARN ]${c_reset} $*"
    fi
}

log_error() {
    echo -e "${c_red}[ERROR]${c_reset} $*"
}

