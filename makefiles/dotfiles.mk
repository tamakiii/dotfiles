.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.config \
	~/.zsh \
	~/.zshrc

uninstall:
	rm -vrf ~/.zshrc
	rm -vrf ~/.zsh
	rm -vrf ~/.config

~/.config: ../.config
	ln -sfnv $(abspath $<) $@

~/.zsh: ../.zsh
	ln -sfnv $(abspath $<) $@

~/.zshrc: ../.zshrc
	ln -sfnv $(abspath $<) $@
