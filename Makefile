.PHONY: help install clean

UNAME := $(shell ./script/os-check.sh)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f $(UNAME).mk $@

clean:
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f $(UNAME).mk $@
