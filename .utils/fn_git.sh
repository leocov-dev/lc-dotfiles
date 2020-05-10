#!/usr/bin/env bash

# shellcheck source=./fn_logging.sh
source "$DOTFILES/.utils/fn_logging.sh"

git_config_contains() {
    while IFS='=' read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "$2" ]]; then
            return 0
        fi
    done < <(git config --global --get-all "$1")

    return 1
}

git_config_is_set() {
    [[ -n "$(git config --global --get "$1")" ]]
    return
}

git_setup_user() {
    if ! git_config_is_set "user.email"; then
        prompt ' - What is your git author name?'
        read -r user_name
        prompt ' - What is your git author email?'
        read -r user_email

        git config --global user.name "$user_name"
        git config --global user.email "$user_email"
    fi
}

git_is_behind() {
    # shellcheck disable=SC2034
    local me=$(git rev-parse "master@{upstream}")
    # shellcheck disable=SC2207
    local parse=($(git ls-remote origin -h "refs/heads/master"))
    local master=${parse[1]}

    log_debug "$me ? $master"

    # shellcheck disable=SC2128
    [[ $me != "$master" ]]
    return
}
