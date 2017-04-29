.PHONY: install update uninstall clean check

DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
MAKE := $(shell which make)

install:
	@type brew > /dev/null 
	@brew tap Homebrew/brewdler
	@brew tap osx-cross/avr

update:
	@type brew > /dev/null 
	@brew update
	@brew bundle --file=$(DIR)/Brewfile

clean:
	@type brew > /dev/null 
	@brew bundle cleanup --force --file=$(DIR)/Brewfile

check:
	@type brew > /dev/null 
	@brew bundle check --file=$(DIR)/Brewfile
	@brew bundle cleanup --file=$(DIR)/Brewfile

