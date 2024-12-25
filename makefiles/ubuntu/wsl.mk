.PHONY: help install uninstall

SHELL := bash --noprofile --norc -eo pipefail

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.config/mimeapps.list \
	~/.local/share/applications/explorer.desktop

uninstall:
	rm -vrf ~/.config/mimeapps.list \
	rm -vrf ~/.local/share/applications/explorer.desktop

~/.config/mimeapps.list: .config/mimeapps.list
	ln -sfnv $(abspath $<) $@

~/.local/share/applications/explorer.desktop: .local/share/applications/explorer.desktop
	ln -sfnv $(abspath $<) $@
