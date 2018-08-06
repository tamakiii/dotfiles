.PHONY: install update uninstall clean check

DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
MAKE := $(shell which make)

install: \
	install/brew \
	install/bundle \
	install/go

install/bundle:
	@type bundle > /dev/null
	@bundle install

install/brew:
	@type brew > /dev/null
	@brew update
	@brew bundle --file=$(DIR)/Brewfile

install/go:
	@type go > /dev/null
	@go get -u github.com/golang/dep/cmd/dep
	@go get -u github.com/jesseduffield/lazygit

import:
	@brew bundle dump --force --file=$(DIR)/Brewfile

clean: \
	clean/brew \
	clean/go

clean/brew:
	@type brew > /dev/null
	@brew bundle cleanup --force --file=$(DIR)/Brewfile

clean/go:
	@go clean -i -n github.com/golang/dep/cmd/dep
	@go clean -i -n github.com/jesseduffield/lazygit

check:
	@type brew > /dev/null
	@brew bundle check --file=$(DIR)/Brewfile
	@brew bundle cleanup --file=$(DIR)/Brewfile

reinstall:
	@type brew > /dev/null
	@grep '^cask' Brewfile
	@grep '^cask' Brewfile | awk '{print $2}' | xargs -I@ brew cask reinstall @

