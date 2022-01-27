.PHONY: help install update dependencies setup clean

SHELL := bash

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	.vim/undo \
	.vim/backup \
	.vim/swapfile \
	.vim/autoload/plug.vim \
	.vim/repos

update:
	vim -E -s +PlugUpdate +visual +qall

dependencies:
	@type vim > /dev/null
	@type curl > /dev/null

.vim/autoload/plug.vim: .vim/autoload
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.vim/repos:
	vim -E -s +PlugInstall +visual +qall

.vim/autoload: .vim
	mkdir -p $@

.vim/backup:
	mkdir -p $@

.vim/swapfile:
	mkdir -p $@

.vim/undo:
	mkdir -p $@

clean:
	rm -rf .vim/backup
	rm -rf .vim/swapfile
	rm -rf .vim/undo

