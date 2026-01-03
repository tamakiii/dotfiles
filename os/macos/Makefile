.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zsh \
	~/.zsh/antigen.zsh \
	~/.zshrc \
	~/.zprofile

uninstall:
	rm -rf ~/.zprofile
	rm -rf ~/.zshrc
	rm -rf ~/.zsh/antigen.zsh
	rm -rf ~/.zsh

~/.zsh:
	mkdir $@

~/.zsh/antigen.zsh:
	curl -L git.io/antigen > $@

~/.zshrc: | .zshrc
	ln -sfnv $(abspath $|) $@

~/.zprofile: | .zprofile
	ln -sfnv $(abspath $|) $@

