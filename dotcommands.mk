.PHONY: help install uninstall status update

git = git -C .dotcommands $1

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.dotcommands

uninstall:
	rm -rf .dotcommands

status:
	git -C .dotcommands status

update:
	git -C .dotcommands pull origin "$$(git -C .dotcommands rev-parse --abbrev-ref @)"

.dotcommands:
	git clone https://github.com/tamakiii/dotcommands.git $@
