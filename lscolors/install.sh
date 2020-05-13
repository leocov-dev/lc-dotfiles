#!/usr/bin/env bash

mkdir /tmp/LS_COLORS && curl -L https://api.github.com/repos/trapd00r/LS_COLORS/tarball/master | tar xzf - --directory=/tmp/LS_COLORS --strip=1
( cd /tmp/LS_COLORS && sh install.sh )
