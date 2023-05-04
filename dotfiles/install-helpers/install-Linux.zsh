#!/usr/bin/env zsh

__apt=(
    micro
)

echo "Updating APT"
sudo apt update

echo "Installing APT Packages"
for package in ${__apt[@]}; do
    sudo apt install -y "$package"
done
