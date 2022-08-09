.PHONY: help install update clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.vim/autoload/plug.vim
	vim -c 'PlugInstall --sync' -c qa

update:
	vim -c 'PlugUpdate --sync' -c qa

~/.vim/autoload/plug.vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
