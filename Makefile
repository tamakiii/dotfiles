.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.zsh \
	.zsh/antigen.zsh

uninstall:
	rm -rf .zsh

.zsh/antigen.zsh:
	curl -L git.io/antigen > $@

.zsh:
	mkdir -p $@
