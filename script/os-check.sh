#!/bin/bash

name=$(uname | tr '[:upper:]' '[:lower:]')

if [[ -f /etc/os-release ]]; then
  name=$(export $(egrep -v '^#' /etc/os-release | grep '^ID=.\+$' | xargs) && echo $ID)
fi

echo $name
