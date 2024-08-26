.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.config \
	~/.zsh \
	~/.zshrc \
	~/.venv

uninstall:
	rm -vrf ~/.venv
	rm -vrf ~/.zshrc
	rm -vrf ~/.zsh
	rm -vrf ~/.config

~/.config: ../.config
	ln -sfnv $(abspath $<) $@

~/.zsh: ../.zsh
	ln -sfnv $(abspath $<) $@

~/.zshrc: ../.zshrc
	ln -sfnv $(abspath $<) $@

~/.venv: ../.venv
	ln -sfnv $(abspath $<) $@
