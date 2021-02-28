#!/usr/bin/env bash

# shellcheck source=./fn_colors.sh
source "$DOTFILES/.utils/fn_colors.sh"
# shellcheck source=./fn_logging.sh
source "$DOTFILES/.utils/fn_logging.sh"
# shellcheck source=./fn_git.sh
source "$DOTFILES/.utils/fn_git.sh"
# shellcheck source=./fn_utils.sh
source "$DOTFILES/.utils/fn_utils.sh"
# shellcheck source=./fn_fonts.sh
source "$DOTFILES/.utils/fn_fonts.sh"



prompt() {
    printf "${c_purple}%s${c_reset}: " "$1"
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

init_dotfiles_env_file() {
    local dotfile=$1
    local dirs=("$DOTFILES"/*/)

    log_debug "$(pp_array "dirs")"

    echo "# Configure dotfile script actions here" >> "$dotfile"

    # shellcheck disable=SC2068
    for dir in ${dirs[@]}; do
        task="$(basename "${dir}")"
        dot="DOTFILES_${task^^}"
        echo "${dot}=false" >> "$dotfile"
    done
}

load_dotfiles_env_file() {
    local defaultLocation="$HOME/.dotfiles.env"
    local envFile=${1:-$defaultLocation}

    if ! file_exists "$envFile"; then
        log_debug "Init new: \"$envFile\""
        init_dotfiles_env_file "$envFile"
        log_warn "Created new: \"$envFile\""
        log_warn "Edit with cmd: ${EDITOR} ${envFile}"
        log_warn "Then run script again"
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

update_system() {
    cascade_command brew \
        "brew update"
    cascade_command apt-get \
        "sudo -n apt-get update"
    if cascade_end; then
        log_error "Failed to update the system package manager"
    fi
}

do_all_install() {
    local install_files=("$DOTFILES"/*/install.sh)

    log_debug "$(pp_array "install_files")"

    # shellcheck disable=SC2068
    for file in ${install_files[@]}; do
        task="$(basename "$(dirname "${file}")")"
        loadDir="DOTFILES_${task^^}"
        [[ ${!loadDir:-false} == true ]] || continue
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
        if git_is_behind "main"; then
            if inside_git_repo; then
                log_info "Updating Dotfiles Repo..."
                git checkout -q main
                git remote update -p > /dev/null
                if ! git pull -q --ff-only; then
                    log_warn "Failed to merge, you might have local changes"
                fi
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
    if [[ -d "$DOTFILES" &&  ${DOTFILES_PROMPT_FOR_UPDATE:-"false"} == "true" ]]; then
        pushd "$DOTFILES" > /dev/null || log_fatal "Failed to cd into $DOTFILES"
        if git_is_behind "main"; then
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
