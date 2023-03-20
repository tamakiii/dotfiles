.PHONY: help install clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.zsh/antigen.zsh

.zsh/antigen.zsh: .zsh
	curl -L git.io/antigen > $@
	chmod u+x $@

.zsh:
	mkdir $@

uninstall:
	rm -rf .zsh/antigen.zsh
