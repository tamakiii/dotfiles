.PHONY: help install clean

UNAME := $(shell uname | tr '[:upper:]' '[:lower:]')
MAKEFILE := $(UNAME).mk

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f $(UNAME).mk $@

clean:
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f $(UNAME).mk $@
