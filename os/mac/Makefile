ROOT := ../..
MYFILES := $(ROOT)/.local/src/tamakiii/myfiles

.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zsh \
	~/.zsh/antigen.zsh \
	~/.zshrc \
	~/.zprofile \
	~/.local/bin/github-mcp-headers \
	~/.local/bin/gw \
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
	~/.config/tmux \
	~/.config/helix \
	~/.config/ghostty/config \
	~/.config/ghostty/themes \
	~/.config/gitmux \
	~/.config/git \
	~/.config/claude \
	~/.claude/skills

uninstall:
	rm -rf ~/.claude/skills
	rm -rf ~/.config/claude
	rm -rf ~/.config/git
	rm -rf ~/.config/gitmux
	rm -rf ~/.config/ghostty/themes
	rm -f ~/.config/ghostty/config
	rm -rf ~/.config/helix
	rm -rf ~/.config/tmux
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
	rm -rf ~/.local/bin/github-mcp-headers
	rm -rf ~/.zprofile
	rm -rf ~/.zshrc
	rm -rf ~/.zsh/antigen.zsh
	rm -rf ~/.zsh

~/.zsh:
	mkdir $@

~/.zsh/antigen.zsh:
	curl -L git.io/antigen > $@

~/.zshrc: | $(ROOT)/.zshrc
	ln -sfnv $(abspath $|) $@

~/.zprofile: | .zprofile
	ln -sfnv $(abspath $|) $@

~/.config/tmux: | .config/tmux
	ln -sfnv $(abspath $|) $@

~/.config/helix: | $(ROOT)/.config/helix
	ln -sfnv $(abspath $|) $@

~/.config/ghostty:
	mkdir -p $@

~/.config/ghostty/config: ~/.config/ghostty | .config/ghostty/config
	ln -sfnv $(abspath $|) $@

~/.config/ghostty/themes: ~/.config/ghostty | $(ROOT)/.config/ghostty/themes
	ln -sfnv $(abspath $|) $@

~/.config/gitmux: | .config/gitmux
	ln -sfnv $(abspath $|) $@

~/.config/git: | .config/git
	ln -sfnv $(abspath $|) $@

~/.config/claude: | $(MYFILES)/os/mac/.config/claude
	ln -sfnv $(abspath $|) $@

~/.local:
	mkdir -p $@

~/.local/bin: ~/.local
	mkdir -p $@

~/.local/bin/github-mcp-headers: ~/.local/bin | bin/github-mcp-headers
	ln -sfnv $(abspath $|) $@

~/.local/bin/gw: ~/.local/bin | bin/gw
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-window-name: ~/.local/bin | $(ROOT)/bin/tmux-window-name
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-pane-label: ~/.local/bin | $(ROOT)/bin/tmux-pane-label
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-rename-sessions: ~/.local/bin | $(ROOT)/bin/tmux-rename-sessions
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-panes: ~/.local/bin | $(ROOT)/bin/tmux-claude-panes
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-status: ~/.local/bin | $(ROOT)/bin/tmux-claude-status
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-launch: ~/.local/bin | $(ROOT)/bin/tmux-claude-launch
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-send: ~/.local/bin | $(ROOT)/bin/tmux-claude-send
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-editor: ~/.local/bin | $(ROOT)/bin/tmux-editor
	ln -sfnv $(abspath $|) $@

~/.local/bin/codium: | ~/.local/bin/tmux-editor
	ln -sfnv tmux-editor $@

~/.local/bin/gh-app-token: ~/.local/bin | $(ROOT)/bin/gh-app-token
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh: ~/.local/bin | .local/bin/gh
	ln -sfnv $(abspath $|) $@

~/.claude/skills: | $(MYFILES)/os/mac/.claude/skills
	ln -sfnv $(abspath $|) $@
