.PHONY: help setup install dependencies versions upgrade update diff unshallow clean

SHELL := bash
DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

help:
	cat $(lastword $(MAKEFILE_LIST))

dependencies:
	type brew > /dev/null
	type git > /dev/null
	type diff > /dev/null

versions:
	@brew --version
	@git --version
	@diff --version | head -n 1

setup: \
	dependencies \
	versions

install: Brewfile
	brew bundle install --file=$<

upgrade: update
	brew upgrade

update:
	brew update

Brewfile:
	brew bundle dump --quiet --file=/dev/stdout | sort > $@

diff:
	@diff -u <(cat Brewfile | sort) <(brew bundle dump --file=/dev/stdout | sort)

unshallow:
	git -C "$$(brew --repo homebrew/core)" fetch --unshallow

clean:
	brew bundle cleanup --force
