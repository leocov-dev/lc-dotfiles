wDir=$(dirname "${BASH_SOURCE[0]}")

# shellcheck source=./colors.sh
source "$wDir/colors.sh"

debug=1
info=2
warn=3
error=4

global_log_level=$info
global_log_level=$debug # TODO: REMOVE  OVERRIDE

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
    if [[ $global_log_level -le $error ]]; then
        echo -e "${c_red}[ERROR]${c_reset} $*"
    fi
}

get_shell() {
    # shellcheck disable=SC2005
    echo "$(ps -p $$ --no-headers -o comm=)"
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
