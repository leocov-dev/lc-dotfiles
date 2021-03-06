#!/usr/bin/env bash

# shellcheck source=./functions.sh
source "$DOTFILES/.utils/functions.sh"
# shellcheck source=./test_functions.sh
source "$DOTFILES/.utils/test_functions.sh"

echo "------------- TEST SUITE ---------------"
echo

a_test "file does exist"
if file_exists "$HOME/.profile"; then
    test_pass
else
    test_fail
fi

a_test "file does not exist"
if file_exists "$HOME/.not_a_real_file"; then
    test_fail
else
    test_pass
fi

a_test "command does exist"
if command_exists man; then
    test_pass
else
    test_fail
fi

a_test "command does not exist"
if command_exists xjkldfaesfg; then
    test_fail
else
    test_pass
fi

a_test "array printing"
expected="Array: \$test_array
        [0] 1
        [1] 2
        [2] A B"
# shellcheck disable=SC2034
test_array=(1 2 "A B")
result="$(pp_array "test_array")"
if [[ "$result" == "$expected" ]]; then
    test_pass
else
    test_fail
    echo "$result"
    echo -e "${c_red}!=${c_reset}"
    echo "$expected"
fi
