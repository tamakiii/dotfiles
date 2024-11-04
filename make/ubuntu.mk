.PHONY: help install update upgrade uninstall

SHELL := bash --noprofile --norc -eo pipefail

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: update
	apt install --no-install-recommends \
		fzf \
		zsh

update:
	apt update

upgrade:
	apt upgrade

uninstall:
	echo "not implemented yet"
	exit 255
