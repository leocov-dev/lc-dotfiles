#!/usr/bin/env zsh

set -e

__dir=${${(%):-%x}:A:h}

# ------------------------------------------------------------------------------
# platform specific dependencies
source "$__dir/install-helpers/install-`uname`.zsh"

# ------------------------------------------------------------------------------
# codenv utilities
source "$__dir/install-helpers/install-codenv-utils.zsh"


#cp -f "${__dir}/dotfiles/.zshrc" "${HOME}/.zshrc"
#cp -f "${__dir}/dotfiles/.zshenv" "${HOME}/.zshenv"

__shell_dir="${HOME}/.local/shell"

# ------------------------------------------------------------------------------
# config files
echo "Copy Configuration Files"
mkdir -p "${__shell_dir}"
rm "${__shell_dir}/*.zsh" || :
cp -fr "${__dir}/shell/." "${__shell_dir}"



echo "----- DONE -----"