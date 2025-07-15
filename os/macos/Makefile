.PHONY: help install check check-dependency uninstall

SHELL := bash --noprofile --norc -eo pipefail

help:
	@cat $(firstword $(MAKEFILE_LIST))

check:
	test -L ~/.zsh
	test -L ~/.zshrc
	test -f ~/.zprofile
	test -L ~/.config/tmux
	test -L ~/.config/helix
	test -L ~/.config/ghostty
	test -f $(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json

check-dependency:
	which zsh > /dev/null || $(error Please install zsh)
	which tmux > /dev/null || $(error Please install tmux)
	which fzf > /dev/null || $(error Please install fzf)
	which hx > /dev/null || $(error Please install hx)

install: \
	.zsh \
	.zsh/antigen.zsh \
	~/.zsh \
	~/.zshrc \
	~/.zprofile \
	~/.config \
	~/.config/tmux \
	~/.config/helix \
	~/.config/ghostty \
	$(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json

uninstall:
	rm -vfr $(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json
	rm -vrf ~/.config/helix
	rm -vrf ~/.config/tmux
	rm -vrf ~/.config/ghostty
	rm -rf ~/.zprofile
	rm -rf ~/.zshrc
	rm -rf ~/.zsh
	rm -rf .zsh

.zsh:
	mkdir $@

.zsh/antigen.zsh:
	curl -L git.io/antigen > $@

~/.zsh: .zsh
	ln -sfnv $(abspath $<) $@

~/.zshrc: .zshrc
	ln -sfnv $(abspath $<) $@

~/.zprofile: .zprofile
	envsubst < $< > $@

~/.config:
	mkdir -p $@

~/.config/tmux: .config/tmux
	ln -sfnv $(abspath $<) $@

~/.config/helix: .config/helix
	ln -sfnv $(abspath $<) $@

~/.config/ghostty: .config/ghostty
	ln -sfnv $(abspath $<) $@

$(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json: Library/Application\ Support/Claude/claude_desktop_config.json
	envsubst < "$<" > "$@"
