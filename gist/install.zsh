#!/usr/bin/env zsh

__dir=${${(%):-%x}:A:h}

# ------------------------------------------------------------------------------
# setup homebrew
if [[ ! $(command -v brew) ]]; then
    echo "brew missing, installing now..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

#brew install -q micro
#brew install -q coreutils
#brew install -q bash
#brew install -q zlib
#brew install -q openssl@1.1
#brew install -q starship
#brew install -q git
#
#brew tap homebrew/cask-fonts
#brew install -q --cask font-jetbrains-mono-nerd-font


if [[ ! -d "${HOME}/.goenv" ]]; then
    git clone https://github.com/syndbg/goenv.git "${HOME}/.goenv"
fi

if [[ ! -d "${HOME}/.pyenv" ]]; then
    git clone https://github.com/pyenv/pyenv.git "${HOME}/.pyenv"
fi

if [[ ! -d "${HOME}/.nodenv" ]]; then
    git clone https://github.com/nodenv/nodenv.git "${HOME}/.nodenv"
    mkdir "${HOME}/.nodenv/plugins"
    git clone https://github.com/nodenv/node-build.git "${HOME}/.nodenv/plugins/node-build"
    git clone https://github.com/nodenv/node-build-update-defs.git "${HOME}/.nodenv/plugins/node-build-update-defs"
fi

cp -f "${__dir}/dotfiles/.zshrc" "${HOME}/.zshrc"
cp -f "${__dir}/dotfiles/.zshenv" "${HOME}/.zshenv"

mkdir -p "${HOME}/.local/shell"
cp -fr "${__dir}/config/." "${HOME}/.local/shell"
