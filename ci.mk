.PHONY: help test setup

SHELL := bash

help:
	@cat $(firstword $(MAKEFILE_LIST))

test: setup
	OSTYPE=test make install

setup:
	brew install tmux
	brew install vim
	brew install zsh
