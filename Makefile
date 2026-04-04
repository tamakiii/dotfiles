UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
  OS := mac
else
  OS := arch
endif

.PHONY: help install uninstall check

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.local/src/tamakiii/myfiles \
	~/.zsh \
	~/.zsh/antigen.zsh \
	~/.zshrc \
	~/.config/tmux \
	~/.config/helix \
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
	~/.local/bin/codium \
	~/.local/bin/gh-app-token \
	~/.local/bin/gh \
	~/.local/bin/gh-as
	$(MAKE) -C .local/src/tamakiii/myfiles install
	$(MAKE) -C os/$(OS) install

uninstall:
	$(MAKE) -C os/$(OS) uninstall
	$(MAKE) -C .local/src/tamakiii/myfiles uninstall
	rm -f ~/.local/bin/gh-as
	rm -f ~/.local/bin/gh
	rm -f ~/.local/bin/gh-app-token
	rm -f ~/.local/bin/codium
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
	rm -rf ~/.config/helix
	rm -rf ~/.config/tmux
	rm -rf ~/.zshrc
	rm -rf ~/.zsh/antigen.zsh
	rm -rf ~/.zsh

check:
	@err=0; \
	for link in \
		~/.zshrc ~/.config/tmux ~/.config/helix ~/.config/ghostty/themes \
		~/.config/gitmux ~/.config/git \
		~/.local/bin/tmux-window-name ~/.local/bin/tmux-pane-label \
		~/.local/bin/tmux-rename-sessions ~/.local/bin/tmux-claude-panes \
		~/.local/bin/tmux-claude-status ~/.local/bin/tmux-claude-launch \
		~/.local/bin/tmux-claude-send ~/.local/bin/tmux-editor \
		~/.local/bin/codium ~/.local/bin/gh-app-token ~/.local/bin/gh \
		~/.local/bin/gh-as \
	; do \
		if [ ! -e "$$link" ]; then \
			echo "BROKEN: $$link"; err=1; \
		fi; \
	done; \
	$(MAKE) -s -C .local/src/tamakiii/myfiles check || err=1; \
	$(MAKE) -s -C os/$(OS) check || err=1; \
	if [ $$err -eq 0 ]; then echo "OK: all symlinks valid"; fi; \
	exit $$err

.local/src/tamakiii/myfiles:
	git clone git@github.com:tamakiii/myfiles.git $@

~/.zsh:
	mkdir $@

~/.zsh/antigen.zsh:
	curl -fL https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh > $@

~/.zshrc: | .zshrc
	ln -sfnv $(abspath $|) $@

~/.config/tmux: | .config/tmux
	ln -sfnv $(abspath $|) $@

~/.config/helix: | .config/helix
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

~/.local/bin/codium: | ~/.local/bin/tmux-editor
	ln -sfnv tmux-editor $@

~/.local/bin/gh-app-token: | bin/gh-app-token
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh: | bin/gh
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh-as: | bin/gh-as
	ln -sfnv $(abspath $|) $@
