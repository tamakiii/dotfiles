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
$DIR/.tmux/plugins/tpm/tpm

ln -fs /usr/local/bin/gcc-9 /usr/local/bin/gcc
ln -fs /usr/local/bin/g++-9 /usr/local/bin/g++

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swapfile
mkdir -p ~/.vim/undo
