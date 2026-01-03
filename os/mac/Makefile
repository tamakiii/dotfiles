.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zsh \
	~/.zsh/antigen.zsh \
	~/.zshrc \
	~/.zprofile \
	~/.claude \
	~/.claude.json \
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
	rm -rf ~/.claude.json
	rm -rf ~/.claude
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

~/.claude: | .claude
	ln -sfnv $(abspath $|) $@

~/.claude.json: | .claude.json
	ln -sfnv $(abspath $|) $@

~/Library/Application\ Support/Claude/claude_desktop_config.json: | Library/Application\ Support/Claude/claude_desktop_config.json
	cp "$|" "$@"
