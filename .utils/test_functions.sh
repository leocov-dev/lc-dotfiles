wDir=$(dirname "${BASH_SOURCE[0]}")

# shellcheck source=./colors.sh
source "$wDir/colors.sh"

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
