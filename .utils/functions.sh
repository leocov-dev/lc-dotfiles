#!/usr/bin/env bash

# shellcheck source=./fn_colors.sh
source "$DOTFILES/.utils/fn_colors.sh"
# shellcheck source=./fn_logging.sh
source "$DOTFILES/.utils/fn_logging.sh"
# shellcheck source=./fn_git.sh
source "$DOTFILES/.utils/fn_git.sh"


prompt() {
    printf "${c_purple}%s${c_reset}: " "$1"
}

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

# Cascade a series of commands proceeding to next command
# if the previous failed and checking final status at the
# end
CASCADE_STATUS=""
cascade_command() {
    local command="$1"
    if [[ $CASCADE_STATUS == "done" ]]; then
        log_debug "Skipping $command..."
        return
    fi

    log_debug "Trying $command..."
    if command_exists "$command"; then
        for var in "${@:2}"; do
            ($var)
        done
        CASCADE_STATUS="done"
    else
        log_debug "Not found: $command"
    fi
}
cascade_end() {
    result=1
    [[ $CASCADE_STATUS = "done" ]] || result=0
    CASCADE_STATUS=0
    return $result
}

# Force a password prompt
force_sudo() {
  if [[ "$EUID" == 0 ]]; then
    log_debug "Already root..."
  else
    sudo -k # make sure to ask for password on next sudo
    if sudo true; then
      log_debug "Correct password!"
    else
      log_error "Wrong password, exiting..."
      exit 1
    fi
  fi
}

# Exit if not already sudo
must_sudo() {
    if ! sudo -n true 2>/dev/null; then
        log_error "Must sudo first..."
        exit 1
    fi
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

load_env_file() {
    local defaultLocation="$HOME/.dotfiles.env"
    local envFile=${1:-$defaultLocation}

    if ! file_exists "$envFile"; then
        log_debug "Failed to find: \"$envFile\""
        return
    fi

    log_debug "Loading env file: \"$envFile\""

    while IFS='=' read -r key temp || [ -n "$key" ]; do
        local key=$(trim "$key")
        local isComment='^[[:space:]]*#'
        local isBlank='^[[:space:]]*$'
        [[ $key =~ $isComment ]] && continue
        [[ $key =~ $isBlank ]] && continue
        local value=$(trim "$temp")
        log_debug "ENV <<< $key='$value'"
        eval export "$key='$value'";
    done < "$envFile"
}

do_all_install() {
    local install_files=("$DOTFILES"/*/install.sh)

    log_debug "$(pp_array "install_files")"

    # shellcheck disable=SC2068
    for file in ${install_files[@]}; do
        task="$(basename "$(dirname "${file}")")"

        envVar="DOTFILES_INSTALL_${task^^}"
        if [[ "${!envVar:-true}" == false ]]; then
            log_debug "Skipping install: $task"
            continue
        fi

        log_info "Installing: $task"
        # shellcheck disable=SC1090
        source "$file"
    done
}

inside_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
    return
}

self_update() {
    if [[ -d "$DOTFILES" ]]; then
        log_debug "Attempt self update..."
        pushd "$DOTFILES" > /dev/null || log_fatal "Failed to cd into $DOTFILES"
        if git_is_behind; then
            if inside_git_repo; then
                log_info "Updating Dotfiles Repo..."
                git checkout -q master
                git remote update -p > /dev/null
                git merge -q --ff-only master
            else
                log_warn "Tried to update but was not git repo..."
            fi
        else
            log_debug "Already up to date..."
        fi
        popd > /dev/null || log_fatal "Failed to popd"
    fi
}

prompt_for_update() {
    if [[ -d "$DOTFILES" ]]; then
        pushd "$DOTFILES" > /dev/null || log_fatal "Failed to cd into $DOTFILES"
        if git_is_behind; then
            echo -e "${c_purple}Dotfiles has an update available!${c_reset}"
            prompt "Update now? (y/n)"
            read -r response
            if [[ $response == "y" ]]; then
                log_debug "Doing update now..."
                self_update
                echo -e "${c_purple}Restart your shell to activate new features!${c_reset}"
            else
                log_debug "Maybe later"
            fi
        fi
        popd > /dev/null || log_fatal "Failed to popd"
    fi
}
