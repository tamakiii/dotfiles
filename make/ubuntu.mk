.PHONY: help install update uninstall

SHELL := bash --noprofile --norc -eo pipefail

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: update
	apt install --no-install-recommends fzf

update:
	apt update

uninstall:
	echo "not implemented yet"
	exit 255
