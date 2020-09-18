.PHONY: help test setup

help:
	@cat $(firstword $(MAKEFILE_LIST))

test: setup
	brew config
	OSTYPE=test make install

setup:
	brew install tmux
	brew install vim
