#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"

echo $OSTYPE

if [[ "$OSTYPE" == "darwin"* ]]; then
  make -f $DIR/brew.mk
fi

make -f $DIR/config.mk
make -C $DIR/etc/init

fish -c "fisher"