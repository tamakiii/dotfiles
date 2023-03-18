.PHONY: help install uninstall

UNAME := $(shell ./script/os-check.sh)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	$(MAKE) -f $(UNAME).mk $@
	$(MAKE) -f nvim.mk $@
	$(MAKE) -f vim.mk $@
	$(MAKE) -f zsh.mk $@
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f npm.mk $@

uninstall:
	$(MAKE) -f $(UNAME).mk $@
	$(MAKE) -f nvim.mk $@
	$(MAKE) -f vim.mk $@
	$(MAKE) -f zsh.mk $@
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f npm.mk $@
