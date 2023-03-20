.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.local/share/nvim/site/autoload/plug.vim

.local/share/nvim/site/autoload/plug.vim: | .local/share/nvim/site/autoload
	curl -sfLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.local/share/nvim/site/autoload:
	mkdir -p $@

uninstall:
	rm -rf .local/share/nvim/site/autoload/plug.vim
