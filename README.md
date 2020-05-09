# Dotfile Management And Bootstrap

## Install
Clone this repo to `~/.dotfiles` or if set env var `DOTFILES`

First time you should run `bin/bootstrap`

## Update
You can always run `bin/update` after the first install

## Settings
Change execution through environment variables

Create a `$DOTFILES/.env` file and add settings to it, one per line (lines starting with `#` are comments).

* `DOTFILES_INSTALL_<NAME>=<boolean (default=true)>`
    * Run the install.sh script for that tool
    * Example: `DOTFILES_INSTALL_AUTOUPDATE=false`
* `DOTFILES_LOAD_PATH_<NAME>=<boolean (default=true)>`
    * Source the path.zsh scripts on shell startup
    * Example: `DOTFILES_LOAD_PATH_PYTHON=false`
* `DOTFILES_LOAD_COMPLETION_<NAME>=<boolean (default=true)>`
    * Source the completion.zsh scripts on shell startup
    * Example: `DOTFILES_LOAD_COMPLETION_GO=false`
* `DOTFILES_LOAD_REMAINDER_<NAME>=<boolean (default=true)>`
    * Source rest of the *.zsh scripts on shell startup
    * Example: `DOTFILES_LOAD_REMAINDER_NODE=false`

## Development
Run tests with `bin/tests`
