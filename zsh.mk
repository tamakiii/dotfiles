.PHONY: help install dependencies build clean

help:
	@cat $(firstword ($MAKEFILE_LIST))

install: \
	dependencies \
	vendor/zsh-users/autosuggestions \
	build

dependencies:
	type zsh > /dev/null

build:
	#

vendor/zsh-users/autosuggestions: vendor/zsh-users
	[[ -d $@ ]] && touch $@ || git clone https://github.com/zsh-users/zsh-autosuggestions.git $@

vendor/zsh-users: vendor
	mkdir $@

vendor:
	mkdir $@

clean:
	rm -rf vendor/
