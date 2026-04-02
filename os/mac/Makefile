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
	~/.config/tmux \
	~/.config/helix \
	~/.config/ghostty \
	~/.config/gitmux \
	~/.config/git \
	~/.config/claude \
	~/Library/Application\ Support/Claude/claude_desktop_config.json

uninstall:
	rm -rf ~/Library/Application\ Support/Claude/claude_desktop_config.json
	rm -rf ~/.config/claude
	rm -rf ~/.config/git
	rm -rf ~/.config/gitmux
	rm -rf ~/.config/ghostty
	rm -rf ~/.config/helix
	rm -rf ~/.config/tmux
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

~/.zshrc: | .zshrc
	ln -sfnv $(abspath $|) $@

~/.zprofile: | .zprofile
	ln -sfnv $(abspath $|) $@

~/.config/tmux: | .config/tmux
	ln -sfnv $(abspath $|) $@

~/.config/helix: | .config/helix
	ln -sfnv $(abspath $|) $@

~/.config/ghostty: | .config/ghostty
	ln -sfnv $(abspath $|) $@

~/.config/gitmux: | .config/gitmux
	ln -sfnv $(abspath $|) $@

~/.config/git: | .config/git
	ln -sfnv $(abspath $|) $@

~/.config/claude: | .config/claude
	ln -sfnv $(abspath $|) $@

~/.local:
	mkdir -p $@

~/.local/bin: ~/.local
	mkdir -p $@

~/.local/bin/github-mcp-headers: ~/.local/bin | bin/github-mcp-headers
	ln -sfnv $(abspath $|) $@

~/.local/bin/gw: ~/.local/bin | bin/gw
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-window-name: ~/.local/bin | bin/tmux-window-name
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-pane-label: ~/.local/bin | bin/tmux-pane-label
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-rename-sessions: ~/.local/bin | bin/tmux-rename-sessions
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-panes: ~/.local/bin | bin/tmux-claude-panes
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-status: ~/.local/bin | bin/tmux-claude-status
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-launch: ~/.local/bin | bin/tmux-claude-launch
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-send: ~/.local/bin | bin/tmux-claude-send
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-editor: ~/.local/bin | bin/tmux-editor
	ln -sfnv $(abspath $|) $@

~/.local/bin/codium: | ~/.local/bin/tmux-editor
	ln -sfnv tmux-editor $@

~/Library/Application\ Support/Claude/claude_desktop_config.json: | Library/Application\ Support/Claude/claude_desktop_config.json
	cp "$|" "$@"
