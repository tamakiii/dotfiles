.PHONY: help install deps uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: Brewfile
	brew bundle install --file=$<

Brewfile:
	brew bundle dump --quiet --file=/dev/stdout | sort > $@

deps:
	brew deps --tree --installed

uninstall:
	brew bundle cleanup --force
