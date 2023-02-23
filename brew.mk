.PHONY: help install clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: Brewfile
	brew bundle install --file=$<

Brewfile:
	brew bundle dump --quiet --file=/dev/stdout | sort > $@

clean:
	brew bundle cleanup --force
