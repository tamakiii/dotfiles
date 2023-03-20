.PHONY: help install uninstall

CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	@$(foreach f, $(DOTFILES), ln -sfnv $(abspath $f) $(HOME)/$f;)

uninstall:
	@-$(foreach f, $(DOTFILES), rm -vrf $(HOME)/$f;)
