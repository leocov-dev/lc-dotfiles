#!/usr/bin/env bash

# shellcheck source=./fn_logging.sh
source "$DOTFILES/.utils/fn_logging.sh"
# shellcheck source=./fn_utils.sh
source "$DOTFILES/.utils/fn_utils.sh"


# https://github.com/ryanoasis/nerd-fonts

manual_nerd_font_install() {
    local nerdFontName=$1

    fontTargetDir="$HOME/.local/share/fonts/${nerdFontName}"

    if [[ -d "$fontTargetDir" ]]; then
        return 0
    else
        tmpArchive="/tmp/$nerdFontName.zip"

        if file_exists "$tmpArchive"; then
            rm "$tmpArchive"
        fi
        curl -sL -o "$tmpArchive" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$nerdFontName.zip"
        if mkdir -p "$fontTargetDir"; then
            unzip -qq "$tmpArchive" "*.otf" -x "*Windows Compatible*" -d "$fontTargetDir"
        else
            log_error "Failed to create font dir $fontTargetDir"
        fi
    fi
}

install_nerd_font() {
    local nerdFontName=$1
    log_info "Installing Nerd-Font: $nerdFontName"

    cascade_command brew \
        "brew tap | grep -q 'homebrew/cask-fonts' || brew tap homebrew/cask-fonts" \
        "brew install --cask font-${nerdFontName,,}-nerd-font"
    cascade_command . \
        "manual_nerd_font_install $nerdFontName"
    if cascade_end; then
        log_error "Failed to install fonts"
    fi
}
