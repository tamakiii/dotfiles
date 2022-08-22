.PHONY: help install clean

UNAME := $(shell ./script/os-check.sh)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	$(MAKE) -f $(UNAME).mk $@
	$(MAKE) -f vim.mk $@
	$(MAKE) -f zsh.mk $@
	$(MAKE) -f dotfiles.mk $@

clean:
	$(MAKE) -f $(UNAME).mk $@
	$(MAKE) -f vim.mk $@
	$(MAKE) -f zsh.mk $@
	$(MAKE) -f dotfiles.mk $@
