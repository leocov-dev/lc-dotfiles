#!/usr/bin/env bash

if [[ ! -d "/tmp/LS_COLORS/" ]]; then
    mkdir /tmp/LS_COLORS
fi

curl -Ls https://api.github.com/repos/trapd00r/LS_COLORS/tarball/master | tar xzf - --directory=/tmp/LS_COLORS --strip=1

pushd /tmp/LS_COLORS > /dev/null || log_fatal "Failed to pushd /tmp/LS_COLORS"
sh install.sh > /dev/null
popd > /dev/null || log_fatal "Failed to popd /tmp/LS_COLORS"
