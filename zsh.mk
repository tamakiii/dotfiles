.PHONY: help install dependencies build clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	vendor/zsh-users/autosuggestions \
	vendor/zsh-users/zsh-syntax-highlighting \
	build

dependencies:
	type zsh > /dev/null

build:
	# OK

vendor/zsh-users/autosuggestions: vendor/zsh-users
	[[ -d $@ ]] && touch $@ || git clone https://github.com/zsh-users/zsh-autosuggestions.git $@

vendor/zsh-users/zsh-syntax-highlighting: vendor/zsh-users
	[[ -d $@ ]] && touch $@ || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $@

vendor/zsh-users: vendor
	mkdir $@

vendor:
	mkdir $@

clean:
	rm -rf vendor/zsh-users/autosuggestions
	rm -rf vendor/zsh-users/zsh-syntax-highlighting
