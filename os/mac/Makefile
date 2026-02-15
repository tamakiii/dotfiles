.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zsh \
	~/.zsh/plugins \
	~/.zsh/aliases.zsh \
	~/.zshrc \
	~/.zprofile \
	~/.claude \
	~/.local/bin/github-mcp-headers \
	~/.ssh/config \
	~/.ssh/sockets \
	~/.ssh/config.d \
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
	rm -rf ~/.local/bin/github-mcp-headers
	rm -rf ~/.claude
	rm -rf ~/.ssh/config
	rm -rf ~/.zprofile
	rm -rf ~/.zshrc
	rm -rf ~/.zsh

~/.zsh:
	mkdir $@

~/.zsh/plugins: ~/.zsh | .zsh/plugins
	ln -sfnv $(abspath $|) $@

~/.zsh/aliases.zsh: ~/.zsh | .zsh/aliases.zsh
	ln -sfnv $(abspath $|) $@

~/.ssh/config: | .ssh/config
	ln -sfnv $(abspath $|) $@

~/.ssh/sockets:
	mkdir -p $@

~/.ssh/config.d:
	mkdir -p $@

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

~/.claude: | .claude
	ln -sfnv $(abspath $|) $@

~/.local:
	mkdir -p $@

~/.local/bin: ~/.local
	mkdir -p $@

~/.local/bin/github-mcp-headers: ~/.local/bin | bin/github-mcp-headers
	ln -sfnv $(abspath $|) $@

~/Library/Application\ Support/Claude/claude_desktop_config.json: | Library/Application\ Support/Claude/claude_desktop_config.json
	cp "$|" "$@"
