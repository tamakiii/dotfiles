.PHONY: install update uninstall cleanup check

DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
MAKE := $(shell which make)

install:
	@type brew >/dev/null 2>&1 && $(MAKE) install-brew

update:
	@type brew >/dev/null 2>&1 && $(MAKE) update-brew

cleanup:
	@$(MAKE) cleanup-brew

check:
	@type brew >/dev/null 2>&1 && brew bundle check --file=$(DIR)/Brewfile
	@brew bundle cleanup --file=$(DIR)/Brewfile

install-brew:
	@brew tap Homebrew/brewdler
	@brew tap osx-cross/avr

update-brew:
	@brew update
	@brew bundle --file=$(DIR)/Brewfile

cleanup-brew:
	@brew bundle cleanup --force --file=$(DIR)/Brewfile

