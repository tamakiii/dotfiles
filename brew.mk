.PHONY: help dependencies install build diff unshallow clean

SHELL := bash
DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

help:
	cat $(lastword $(MAKEFILE_LIST))

dependencies:
	type brew > /dev/null
	type git > /dev/null

install: \
	dependencies \
	build

build:
	brew bundle install

Brewfile:
	brew bundle dump --file=/dev/stdout | sort > $@

diff:
	@diff -u <(cat Brewfile | sort) <(brew bundle dump --file=/dev/stdout | sort)

unshallow:
	git -C "$$(brew --repo homebrew/core)" fetch --unshallow

clean:
	brew bundle cleanup --force
