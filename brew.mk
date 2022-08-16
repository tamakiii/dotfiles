.PHONY: help install

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: Brewfile
	brew bundle install --file=$<
