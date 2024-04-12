.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	$(MAKE) -f brew.mk $@

uninstall:
	$(MAKE) -f brew.mk $@
