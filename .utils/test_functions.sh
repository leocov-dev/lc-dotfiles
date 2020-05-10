#!/usr/bin/env bash

# shellcheck source=./fn_colors.sh
source "$DOTFILES/.utils/fn_colors.sh"

a_test() {
    printf "${c_blue}TEST: $*${c_reset}"
}

test_pass() {
    echo -e "${c_green} > PASS${c_reset}"
}

test_fail() {
    echo -e "${c_red} > FAIL${c_reset}"
}

test_fail_hard() {
    test_fail
    exit 1
}
