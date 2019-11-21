#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"

echo "---"
echo $OSTYPE
echo "---"

make -f $DIR/brew.mk
make -f $DIR/config.mk
make -C $DIR/etc/init

fish -c "fisher"