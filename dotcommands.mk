.PHONY: help install uninstall

git = git -C .dotcommands $1

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.dotcommands

uninstall:
	rm -rf ~/.dotcommands

~/.dotcommands:
	git clone https://github.com/tamakiii/dotcommands.git $@
