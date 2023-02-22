.PHONY: help update

help:
	@cat $(firstword $(MAKEFILE_LIST))

update:
	brew update
	brew untap homebrew/core
	brew untap homebrew/cask
	brew cleanup
