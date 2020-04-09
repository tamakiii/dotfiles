.PHONY: help dependencies install update upgrade uninstsall diff check cleanup reinstall unshallow clean

SHELL := bash

DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

help:
	cat $(lastword $(MAKEFILE_LIST))

dependencies:
	type brew > /dev/null
	type git > /dev/null

install: dependencies
	brew bundle install --file=$(DIR)/Brewfile

update:
	brew update

upgrade:
	brew upgrade

Brewfile:
	brew bundle dump --file=/dev/stdout | sort > $(DIR)/Brewfile

uninstall:
	diff -u <(brew bundle list --taps) <(cat Brewfile | grep '^tap' | sed 's/tap[ ]*"\(.*\)"/\1/') | xargs brew untap
	diff -u <(brew bundle list --brews) <(cat Brewfile | grep '^brew' | sed 's/brew[ ]*"\(.*\)"/\1/') | xargs brew uninstall
	diff -u <(brew bundle list --casks) <(cat Brewfile | grep '^cask' | sed 's/cask[ ]*"\(.*\)"/\1/') | xargs brew cask uninstall

diff:
	diff -u <(brew bundle list --taps) <(cat Brewfile | grep '^tap' | sed 's/tap[ ]*"\(.*\)"/\1/') || true
	diff -u <(brew bundle list --brews) <(cat Brewfile | grep '^brew' | sed 's/brew[ ]*"\(.*\)"/\1/') || true
	diff -u <(brew bundle list --casks) <(cat Brewfile | grep '^cask' | sed 's/cask[ ]*"\(.*\)"/\1/') || true

check:
	brew bundle check --file=$(DIR)/Brewfile

cleanup:
	brew bundle cleanup --file=$(DIR)/Brewfile

reinstall:
	grep '^cask' Brewfile | awk '{print $2}' | xargs -I@ brew cask reinstall @

update-reset:
	brew update-reset

unshallow:
	git -C "$$(brew --repo homebrew/core)" fetch --unshallow

clean:
	brew bundle cleanup --force --file=$(DIR)/Brewfile
