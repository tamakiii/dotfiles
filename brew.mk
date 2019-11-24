.PHONY: Brewfile

SHELL := bash

DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

install:
	@type brew > /dev/null
	@brew bundle install --file=$(DIR)/Brewfile

update:
	@type brew > /dev/null
	@brew update

Brewfile:
	@type brew > /dev/null
	@brew bundle dump --file=/dev/stdout | sort > $(DIR)/Brewfile

uninstall:
	@type brew > /dev/null
	diff -u <(brew bundle list --taps) <(cat Brewfile | grep '^tap' | sed 's/tap[ ]*"\(.*\)"/\1/') | xargs brew untap
	diff -u <(brew bundle list --brews) <(cat Brewfile | grep '^brew' | sed 's/brew[ ]*"\(.*\)"/\1/') | xargs brew uninstall
	diff -u <(brew bundle list --casks) <(cat Brewfile | grep '^cask' | sed 's/cask[ ]*"\(.*\)"/\1/') | xargs brew cask uninstall

diff:
	@type brew > /dev/null
	diff -u <(brew bundle list --taps) <(cat Brewfile | grep '^tap' | sed 's/tap[ ]*"\(.*\)"/\1/') || true
	diff -u <(brew bundle list --brews) <(cat Brewfile | grep '^brew' | sed 's/brew[ ]*"\(.*\)"/\1/') || true
	diff -u <(brew bundle list --casks) <(cat Brewfile | grep '^cask' | sed 's/cask[ ]*"\(.*\)"/\1/') || true

check:
	@type brew > /dev/null
	@brew bundle check --file=$(DIR)/Brewfile

cleanup:
	@type brew > /dev/null
	@brew bundle cleanup --file=$(DIR)/Brewfile

reinstall:
	@type brew > /dev/null
	@grep '^cask' Brewfile | awk '{print $2}' | xargs -I@ brew cask reinstall @

update-reset:
	@type brew > /dev/null
	@brew update-reset

unshallow:
	 git -C "$$(brew --repo homebrew/core)" fetch --unshallow

clean:
	@type brew > /dev/null
	@brew bundle cleanup --force --file=$(DIR)/Brewfile
