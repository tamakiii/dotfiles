.PHONY: install update uninstall clean check

DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
MAKE := $(shell which make)

install: update

update:
	@type brew > /dev/null
	@brew update
	@brew bundle --file=$(DIR)/Brewfile

import:
	@brew bundle dump --force --file=$(DIR)/Brewfile

clean:
	@type brew > /dev/null
	@brew bundle cleanup --force --file=$(DIR)/Brewfile

check:
	@type brew > /dev/null
	@brew bundle check --file=$(DIR)/Brewfile
	@brew bundle cleanup --file=$(DIR)/Brewfile

reinstall:
	@type brew > /dev/null
	@grep '^cask' Brewfile
	@grep '^cask' Brewfile | awk '{print $2}' | xargs -I@ brew cask reinstall @

