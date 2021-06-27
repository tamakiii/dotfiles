.PHONY: help setup install dependencies clean
.PHONY: dotfiles zsh tmux vim npm

SHELL := bash

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup:
	[[ "$$OSTYPE" == "darwin"* ]] && $(MAKE) -f brew.mk setup install

install: \
	dependencies \
	dotfiles \
	zsh \
	tmux \
	vim \
	npm \
	dotfiles

dependencies:
	type make > /dev/null

dotfiles:
	$(MAKE) -f dotfiles.mk install

zsh:
	$(MAKE) -f zsh.mk install

tmux:
	$(MAKE) -f tmux.mk install

vim:
	$(MAKE) -f vim.mk install

npm:
	$(MAKE) -f npm.mk install

clean:
	$(MAKE) -f dotfiles.mk clean
	$(MAKE) -f zsh.mk clean
	$(MAKE) -f tmux.mk clean
	$(MAKE) -f vim.mk clean
	$(MAKE) -f npm.mk clean
