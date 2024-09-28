.PHONY: help install uninstall check

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.zsh \
	.zsh/antigen.zsh \
	~/.zsh \
	~/.zshrc \
	~/.config \
	~/.config/tmux \
	~/.config/helix

uninstall:
	rm -vrf ~/.config/helix
	rm -vrf ~/.config/tmux
	rm -rf ~/.zshrc
	rm -rf ~/.zsh
	rm -rf .zsh

check:
	test -L ~/.zsh
	test -L ~/.zshrc
	test -L ~/.config/tmux
	test -L ~/.config/helix
	which zsh
	which fzf

.zsh:
	mkdir $@

.zsh/antigen.zsh:
	curl -L git.io/antigen > $@

~/.zsh: .zsh
	ln -sfnv $(abspath $<) $@

~/.zshrc: .zshrc
	ln -sfnv $(abspath $<) $@

~/.config:
	mkdir $@

~/.config/tmux: .config/tmux
	ln -sfnv $(abspath $<) $@

~/.config/helix: .config/helix
	ln -sfnv $(abspath $<) $@
