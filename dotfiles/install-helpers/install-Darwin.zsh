#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# setup homebrew
if [[ ! $(command -v brew) ]]; then
    echo "brew missing, installing now..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

__brew_formulas=(
  micro
  coreutils
  bash
  zlib
  openssl@1.1
  starship
  git
)

__brew_tap=(
  homebrew/cask-fonts
)

__brew_casks=(
  font-jetbrains-mono-nerd-font
)

echo "Update Brew"
brew update -q

echo "Installing Brew Formulas"
for formula in ${__brew_formulas[@]}; do
  brew install -q "$formula"
done

echo "Tapping Brew Casks"
for tap in ${__brew_tap[@]}; do
  brew tap "$tap"
done

echo "Installing Brew Casks"
for cask in ${__brew_casks[@]}; do
  brew install -q --cask "$cask"
done