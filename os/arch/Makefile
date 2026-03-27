.PHONY: help install uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zsh \
	~/.zsh/antigen.zsh \
	~/.zshrc \
	~/.zprofile \
	~/.claude \
	~/.config/tmux \
	~/.config/helix \
	~/.config/ghostty \
	~/.config/gitmux \
	~/.config/git \
	~/.config/claude \
	~/.config/hypr \
	~/.local/bin/pbcopy \
	~/.local/bin/pbpaste \
	~/.local/bin/tmux-claude-panes \
	~/.local/bin/tmux-claude-status \
	~/.local/bin/gh-app-token \
	~/.claude/bin/gh \
	~/.openclaw/bin/gh \
	~/.local/share/applications/steam.desktop \
	~/.local/share/applications/discord.desktop

uninstall:
	rm -f ~/.local/share/applications/discord.desktop
	rm -f ~/.local/share/applications/steam.desktop
	rm -f ~/.claude/bin/gh
	rm -f ~/.openclaw/bin/gh
	rm -f ~/.local/bin/gh-app-token
	rm -f ~/.local/bin/tmux-claude-status
	rm -f ~/.local/bin/tmux-claude-panes
	rm -f ~/.local/bin/pbpaste
	rm -f ~/.local/bin/pbcopy
	rm -rf ~/.config/hypr
	rm -rf ~/.config/claude
	rm -rf ~/.config/git
	rm -rf ~/.config/gitmux
	rm -rf ~/.config/ghostty
	rm -rf ~/.config/helix
	rm -rf ~/.config/tmux
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

~/.config/hypr: | .config/hypr
	ln -sfnv $(abspath $|) $@

~/.local/bin/pbcopy: | bin/pbcopy
	ln -sfnv $(abspath $|) $@

~/.local/bin/pbpaste: | bin/pbpaste
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-panes: | bin/tmux-claude-panes
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh-app-token: | bin/gh-app-token
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-status: | bin/tmux-claude-status
	ln -sfnv $(abspath $|) $@

~/.claude/bin:
	mkdir -p $@

~/.claude/bin/gh: ~/.claude/bin | .claude/bin/gh
	ln -sfnv $(abspath $(word 2,$^)) $@

~/.openclaw/bin:
	mkdir -p $@

~/.openclaw/bin/gh: ~/.openclaw/bin | .openclaw/bin/gh
	ln -sfnv $(abspath $(word 2,$^)) $@

~/.local/share/applications:
	mkdir -p $@

~/.local/share/applications/steam.desktop: ~/.local/share/applications | .local/share/applications/steam.desktop
	ln -sfnv $(abspath $(word 2,$^)) $@

~/.local/share/applications/discord.desktop: ~/.local/share/applications | .local/share/applications/discord.desktop
	ln -sfnv $(abspath $(word 2,$^)) $@
