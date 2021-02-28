#!/usr/bin/env zsh

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# forces zsh to realize new commands
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# rehash if command not found (possibly recently installed)
zstyle ':completion:*' rehash true

# menu if nb items > 2
zstyle ':completion:*' menu select=2

 # group results by category
zstyle ':completion:*' group-name ''
