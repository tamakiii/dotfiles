#!/usr/bin/env bash

if [ -f /etc/os-release ]; then
  # freedesktop.org and systemd
  source /etc/os-release
  echo "NAME=${NAME}"
  echo "VERSION=${VERSION}"
else
  # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
  echo "NAME=$(uname -s)"
  echo "VERSION=$(uname -r)"
fi
