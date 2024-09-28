.PHONY: help install uninstall check

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.config \
	~/.config/tmux \
	~/.config/helix

uninstall:
	rm -vrf ~/.config/helix
	rm -vrf ~/.config/tmux

check:
	test -L ~/.config/tmux
	test -L ~/.config/helix

~/.config:
	mkdir $@

~/.config/tmux: .config/tmux
	ln -sfnv $(abspath $<) $@

~/.config/helix: .config/helix
	ln -sfnv $(abspath $<) $@
