.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	$(MAKE) -f dotfiles.mk $@
	$(MAKE) -f brew.mk $@

uninstall:
	$(MAKE) -f brew.mk $@
	$(MAKE) -f dotfiles.mk $@
