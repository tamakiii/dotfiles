.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.config

uninstall:
	rm -vrf ~/.config

~/.config: ../.config
	ln -sfnv $(abspath $<) $@
