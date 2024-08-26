.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: ../Brewfile
	brew bundle install --file=$<

uninstall:
	brew bundle cleanup --force

../Brewfile:
	brew bundle dump --quiet --file=/dev/stdout | sort > $@
