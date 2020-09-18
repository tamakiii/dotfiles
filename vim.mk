.PHONY: help install dependencies setup clean

SHELL := bash

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	setup \
	.vim/repos

dependencies:
	@type vim > /dev/null

setup: \
	.vim/backup \
	.vim/swapfile \
	.vim/undo

.vim/repos:
	vim -E -s -u ~/.vimrc +PlugInstall +qall

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

