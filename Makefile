.PHONY: help setup teardown
.PHONY: install install-myfiles install-os 
.PHONY: uninstall uninstall-os uninstall-myfiles
.PHONY: check check-myfiles check-os

UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
  OS := mac
else
  OS := arch
endif

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	~/.myfiles

teardown:
	rm -rf ~/.myfiles

install: setup \
	~/.zsh \
	~/.zsh/antigen.zsh \
	~/.zshrc \
	~/.config/tmux \
	~/.config/ghostty/themes \
	~/.config/gitmux \
	~/.config/git \
	~/.local/bin/tmux-window-name \
	~/.local/bin/tmux-pane-label \
	~/.local/bin/tmux-rename-sessions \
	~/.local/bin/tmux-claude-panes \
	~/.local/bin/tmux-claude-status \
	~/.local/bin/tmux-claude-launch \
	~/.local/bin/tmux-claude-send \
	~/.local/bin/tmux-editor \
	~/.local/bin/gh-app-token \
	~/.local/bin/gh \
	~/.local/bin/gh-as \
	~/.local/bin/gh-apps \
	~/.local/bin/gh-webhooks \
	install-myfiles \
	install-os

uninstall: uninstall-os uninstall-myfiles
	rm -f ~/.local/bin/gh-webhooks
	rm -f ~/.local/bin/gh-apps
	rm -f ~/.local/bin/gh-as
	rm -f ~/.local/bin/gh
	rm -f ~/.local/bin/gh-app-token
	rm -f ~/.local/bin/tmux-editor
	rm -f ~/.local/bin/tmux-claude-send
	rm -f ~/.local/bin/tmux-claude-launch
	rm -f ~/.local/bin/tmux-claude-status
	rm -f ~/.local/bin/tmux-claude-panes
	rm -f ~/.local/bin/tmux-rename-sessions
	rm -f ~/.local/bin/tmux-pane-label
	rm -f ~/.local/bin/tmux-window-name
	rm -rf ~/.config/git
	rm -rf ~/.config/gitmux
	rm -rf ~/.config/ghostty/themes
	rm -rf ~/.config/tmux
	rm -rf ~/.zshrc
	rm -rf ~/.zsh/antigen.zsh
	rm -rf ~/.zsh

install-myfiles:
	$(MAKE) -C ~/.myfiles install

uninstall-myfiles:
	$(MAKE) -C ~/.myfiles uninstall

install-os:
	$(MAKE) -C os/$(OS) install

uninstall-os:
	$(MAKE) -C os/$(OS) uninstall

LINKS := \
	~/.zshrc ~/.config/tmux ~/.config/ghostty/themes \
	~/.config/gitmux ~/.config/git \
	~/.local/bin/tmux-window-name ~/.local/bin/tmux-pane-label \
	~/.local/bin/tmux-rename-sessions ~/.local/bin/tmux-claude-panes \
	~/.local/bin/tmux-claude-status ~/.local/bin/tmux-claude-launch \
	~/.local/bin/tmux-claude-send ~/.local/bin/tmux-editor \
	~/.local/bin/gh-app-token ~/.local/bin/gh \
	~/.local/bin/gh-as ~/.local/bin/gh-apps ~/.local/bin/gh-webhooks

check: check-myfiles check-os
	@for link in $(LINKS); do \
		test -e "$$link" || { echo "BROKEN: $$link"; exit 1; }; \
	done; \
	echo "OK: all symlinks valid"

check-myfiles:
	$(MAKE) -s -C ~/.myfiles check

check-os:
	$(MAKE) -s -C os/$(OS) check

~/.myfiles:
	git clone git@github.com:tamakiii/myfiles.git $@

~/.zsh:
	mkdir $@

~/.zsh/antigen.zsh:
	curl -fL https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh > $@

~/.zshrc: | .zshrc
	ln -sfnv $(abspath $|) $@

~/.config/tmux: | .config/tmux
	ln -sfnv $(abspath $|) $@

~/.config/ghostty:
	mkdir -p $@

~/.config/ghostty/themes: ~/.config/ghostty | .config/ghostty/themes
	ln -sfnv $(abspath $|) $@

~/.config/gitmux: | .config/gitmux
	ln -sfnv $(abspath $|) $@

~/.config/git: | .config/git
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-window-name: | bin/tmux-window-name
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-pane-label: | bin/tmux-pane-label
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-rename-sessions: | bin/tmux-rename-sessions
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-panes: | bin/tmux-claude-panes
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-status: | bin/tmux-claude-status
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-launch: | bin/tmux-claude-launch
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-send: | bin/tmux-claude-send
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-editor: | bin/tmux-editor
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh-app-token: | bin/gh-app-token
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh: | bin/gh
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh-as: | bin/gh-as
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh-apps: | bin/gh-apps
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh-webhooks: | bin/gh-webhooks
	ln -sfnv $(abspath $|) $@
