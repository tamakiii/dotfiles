#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"

make -C $DIR/etc/init

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ "$SKIP_BREW" != "1" ]]; then
    make -f $DIR/brew.mk
  fi
fi

make -f $DIR/config.mk

fish -c "fisher"
vim -E -s -u ~/.vimrc +PlugInstall +qall

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swapfile
mkdir -p ~/.vim/undo
