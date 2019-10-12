DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: install

install:
	@type brew > /dev/null
	@brew update
	@brew bundle --file=$(DIR)/Brewfile

update:
	@type brew > /dev/null
	@brew bundle dump --force --file=$(DIR)/Brewfile

check:
	@type brew > /dev/null
	@brew bundle check --file=$(DIR)/Brewfile

cleanup:
	@type brew > /dev/null
	@brew bundle cleanup --file=$(DIR)/Brewfile

reinstall:
	@type brew > /dev/null
	@grep '^cask' Brewfile
	@grep '^cask' Brewfile | awk '{print $2}' | xargs -I@ brew cask reinstall @

clean:
	@type brew > /dev/null
	@brew bundle cleanup --force --file=$(DIR)/Brewfile
