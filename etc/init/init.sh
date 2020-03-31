#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ "$SKIP_BREW" != "1" ]]; then
    make -f $DIR/brew.mk
  fi
fi

vim -E -s -u ~/.vimrc +PlugInstall +qall
$DIR/.tmux/plugins/tpm/tpm

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swapfile
mkdir -p ~/.vim/undo
