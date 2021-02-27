#!/usr/bin/env bash

# shellcheck source=./fn_logging.sh
source "$DOTFILES/.utils/fn_logging.sh"
# shellcheck source=./fn_utils.sh
source "$DOTFILES/.utils/fn_utils.sh"

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
    local branch="${1:-master}"
    # shellcheck disable=SC2034
    local me=$(git rev-parse "$branch@{upstream}")
    # shellcheck disable=SC2207
    local parseMe=$(git ls-remote origin -h "refs/heads/$branch")
    local remote=$(trim "${parseMe%"refs/heads/$branch"}")

    log_debug "$me ? $remote"

    # shellcheck disable=SC2128
    [[ $me != "$remote" ]]
    return
}

git_pull() {
    local branch="${2:-master}"
    if [[ -d "$1" ]]; then
        pushd "$1"  > /dev/null || log_fatal "Failed to cd into $1"
        if git_is_behind "$branch"; then
            git checkout -q "$branch"
            git remote update -p > /dev/null
            if ! git pull -q --ff-only; then
                log_warn "Failed to merge, you might have local changes"
            fi
        else
            log_debug 'Git was not behind...'
        fi
        popd > /dev/null || log_error "Failed to restore directory"
    else
        log_error "Failed to find directory '$1'"
    fi
}
