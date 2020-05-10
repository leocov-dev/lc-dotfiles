# Dotfile Management And Bootstrap

## Install
Requires `zsh` shell

Clone this repo to `~/.dotfiles` or if set env var `DOTFILES`
`git clone git@github.com:leocov-dev/dotfiles.git ~/.dotfiles`

Run `bin/bootstrap`

## Update
You can always run `bootstrap!` or `bin/bootstrap` again to get the latest.
Reload your shell with `reload!`

## Settings
Change execution through environment variables

Create a `~/.dotfiles.env` file and add settings to it, one per line (lines starting with `#` are comments).

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

## Notes
Inspired by: [caarlos0/dotfiles](https://github.com/caarlos0/dotfiles/)
