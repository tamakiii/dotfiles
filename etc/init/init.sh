#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ "$SKIP_BREW" != "1" ]]; then
    make -C $DIR -f brew.mk
  fi
fi

make -C $DIR install
