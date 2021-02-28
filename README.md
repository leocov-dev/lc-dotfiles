# Dotfile Management And Bootstrap

## Install
Requires `zsh` shell

Clone this repo to `~/.dotfiles`

```
$ git clone git@github.com:leocov-dev/dotfiles.git ~/.dotfiles
```
>You may alternatively clone to any location and create a simlink to `~/.dotfiles`.
>
>If you don't want to or can't use `~/.dotfiles` for the repo root
>then you can clone to any location but **MUST** setup your shell to populate
>the environment variable `DOTFILES` with the repo location.


Initialize with:
```
$ .bin/bootstrap
```


## Update
Pull the lastest changes from the git repo and execute the command `$ bootstrap!`.

Reload your shell with the command `$ reload!`

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
Run tests with the command
```
$ .bin/tests
```

## Notes
Inspired by: [caarlos0/dotfiles](https://github.com/caarlos0/dotfiles/)
