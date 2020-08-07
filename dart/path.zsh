#!/usr/bin/env bash

# NODE
export DART_ROOT="/usr/lib/dart"

if [[ -d "$DART_ROOT" ]]; then
    log_debug "Loading 'dart' from $DART_ROOT"
    export PATH="$DART_ROOT/bin:$PATH"

    export DART_PUB_CACHE="$HOME/.pub-cache/bin"

    if [[ -d "$DART_PUB_CACHE" ]]; then
        log_debug "Loading 'dart pub cache' from $DART_PUB_CACHE"
        export PATH="$DART_PUB_CACHE:$PATH"
    else
        log_debug "Failed to find: $DART_PUB_CACHE"
    fi
else
    log_warn "Failed to find: $DART_ROOT"
fi
