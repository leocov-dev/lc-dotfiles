#!/usr/bin/env bash

get_shell() {
    result=$(ps -p $$ -o "comm=")
    # shellcheck disable=SC2005
    echo "${result#"-"}"
}

pp_array() {
    local array_name=$1
    local array=()
    local start=0

    case $(get_shell) in
        *zsh)
            start=1
            # shellcheck disable=SC2206
            array=(${(P)array_name})
            ;;
        *bash)
            # shellcheck disable=SC2125,SC1087
            local a_tmp=$array_name[@]
            array=("${!a_tmp}")
            ;;
        *) ;;
            # assume something else
    esac

    echo "Array: \$${array_name}"
    for ((i = start; i < ${#array[@]}; i++)); do
        echo "        [$i] ${array[$i]}"
    done
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# check for file
file_exists() {
    [[ -f "$1" ]]
    return
}

directory_exists() {
    [[ -d "$1" ]]
    return
}

os_type () {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
    echo ${machine}
}

trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"
    printf '%s' "$var"
}
