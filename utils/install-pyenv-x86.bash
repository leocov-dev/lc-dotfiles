#!/usr/bin/env bash

__version=${1}

if [[ -z $__version ]]; then
  echo "call with desired python version - ./install-pyenv-x86 <version>"
  exit 1
fi

CFLAGS="-I$(brew86 --prefix openssl@1.1)/include -I$(brew86 --prefix zlib) -I$(brew86 --prefix readline)/include" \
LDFLAGS="-L$(brew86 --prefix openssl@1.1)/lib -L$(brew86 --prefix readline)/lib" \
VERSION_ALIAS="${__version}_x86" \
pyenv86 install -v "${__version}"