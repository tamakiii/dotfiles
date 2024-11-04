.PHONY: help install check uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	winget install 9NT1R1C2HH7J # https://apps.microsoft.com/detail/9nt1r1c2hh7j

check:
	test -L ~/AppData/Roaming/helix/config.toml
	test -L ~/AppData/Roaming/helix/themes

uninstall:
	echo "not implemented yet"
	exit 255
