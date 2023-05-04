#!/usr/bin/env zsh

set -e

_current_dir=${${(%):-%x}:A:h}

# ------------------------------------------------------------------------------
# platform specific dependencies
source "${_current_dir}/install-helpers/install-`uname`.zsh"

# ------------------------------------------------------------------------------
# codenv utilities
source "${_current_dir}/install-helpers/install-codenv-utils.zsh"

# ------------------------------------------------------------------------------
# config files
__shell_dir="${HOME}/.local/shell"

echo "Copy Configuration Files"
mkdir -p ${__shell_dir}
rm -r ${__shell_dir}/* || :
cp -fr ${_current_dir}/shell/. ${__shell_dir}


_zshrc_line='source "${HOME}/.local/shell/dot.rc.zsh"'
if ! grep -Fqx ${_zshrc_line} "${HOME}/.zshrc"; then
    echo "Update .zshrc"
    echo "\n${_zshrc_line}" >> "${HOME}/.zshrc"
fi

_zshenv_line='source "${HOME}/.local/shell/dot.env.zsh"'
if ! grep -Fqx ${_zshenv_line} "${HOME}/.zshenv"; then
    echo "Update .zshenv"
    echo "\n${_zshenv_line}" >> "${HOME}/.zshenv"
fi

echo "----- DONE -----"
