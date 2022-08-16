.PHONY: help install clean

UNAME := $(shell ./script/os-check.sh)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	$(MAKE) -f $(UNAME).mk $@
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f vim.mk $@

clean:
	$(MAKE) -f $(UNAME).mk $@
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f vim.mk $@
