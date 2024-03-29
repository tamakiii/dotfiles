.PHONY: help install update uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.vim/autoload/plug.vim
	vim -c 'PlugInstall --sync' -c qa

update:
	vim -c 'PlugUpdate --sync' -c qa

.vim/autoload/plug.vim: .vim/autoload
	curl -fLo $@ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.vim/autoload:
	mkdir -p .vim/autoload

uninstall:
	rm -rf .vim/autoload
