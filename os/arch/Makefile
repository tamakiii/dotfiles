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
	~/.claude/settings.json \
	~/.claude/bin/gh \
	~/.claude/bin/statusline.sh \
	~/.codex/bin/gh \
	~/.openclaw/bin/gh \
	~/.config/tmux \
	~/.config/helix \
	~/.config/ghostty/config \
	~/.config/ghostty/themes \
	~/.config/gitmux \
	~/.config/git \
	~/.config/claude \
	~/.config/hypr \
	~/.local/bin/pbcopy \
	~/.local/bin/pbpaste \
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
	~/.claude/skills \
	~/.codex/skills

uninstall:
	rm -rf ~/.codex/skills
	rm -rf ~/.claude/skills
	rm -f ~/.local/bin/gh
	rm -f ~/.local/bin/gh-app-token
	rm -f ~/.local/bin/codium
	rm -f ~/.local/bin/tmux-editor
	rm -f ~/.local/bin/tmux-claude-send
	rm -f ~/.local/bin/tmux-claude-launch
	rm -f ~/.local/bin/tmux-rename-sessions
	rm -f ~/.local/bin/tmux-pane-label
	rm -f ~/.local/bin/tmux-window-name
	rm -f ~/.local/bin/tmux-claude-status
	rm -f ~/.local/bin/tmux-claude-panes
	rm -f ~/.local/bin/pbpaste
	rm -f ~/.local/bin/pbcopy
	rm -rf ~/.config/hypr
	rm -rf ~/.config/claude
	rm -rf ~/.config/git
	rm -rf ~/.config/gitmux
	rm -rf ~/.config/ghostty/themes
	rm -f ~/.config/ghostty/config
	rm -rf ~/.config/helix
	rm -rf ~/.config/tmux
	rm -f ~/.claude/settings.json
	rm -f ~/.claude/bin/statusline.sh
	rm -f ~/.claude/bin/gh
	rm -f ~/.codex/bin/gh
	rm -f ~/.openclaw/bin/gh
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

~/.config/claude: | $(MYFILES)/os/arch/.config/claude
	ln -sfnv $(abspath $|) $@

~/.config/hypr: | .config/hypr
	ln -sfnv $(abspath $|) $@

~/.local/bin/pbcopy: | bin/pbcopy
	ln -sfnv $(abspath $|) $@

~/.local/bin/pbpaste: | bin/pbpaste
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-window-name: | $(ROOT)/bin/tmux-window-name
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-pane-label: | $(ROOT)/bin/tmux-pane-label
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-rename-sessions: | $(ROOT)/bin/tmux-rename-sessions
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-panes: | $(ROOT)/bin/tmux-claude-panes
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh-app-token: | $(ROOT)/bin/gh-app-token
	ln -sfnv $(abspath $|) $@

~/.local/bin/gh: | .local/bin/gh
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-status: | $(ROOT)/bin/tmux-claude-status
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-launch: | $(ROOT)/bin/tmux-claude-launch
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-claude-send: | $(ROOT)/bin/tmux-claude-send
	ln -sfnv $(abspath $|) $@

~/.local/bin/tmux-editor: | $(ROOT)/bin/tmux-editor
	ln -sfnv $(abspath $|) $@

~/.local/bin/codium: | ~/.local/bin/tmux-editor
	ln -sfnv tmux-editor $@

~/.claude/settings.json: | $(MYFILES)/.claude/settings.json
	ln -sfnv $(abspath $|) $@

~/.claude/bin:
	mkdir -p $@

~/.claude/bin/gh: ~/.claude/bin | $(MYFILES)/os/arch/.claude/bin/gh
	ln -sfnv $(abspath $|) $@

~/.claude/bin/statusline.sh: ~/.claude/bin | $(MYFILES)/.claude/bin/statusline.sh
	ln -sfnv $(abspath $|) $@

~/.codex/bin:
	mkdir -p $@

~/.codex/bin/gh: ~/.codex/bin | $(MYFILES)/os/arch/.codex/bin/gh
	ln -sfnv $(abspath $|) $@

~/.openclaw/bin:
	mkdir -p $@

~/.openclaw/bin/gh: ~/.openclaw/bin | $(MYFILES)/os/arch/.openclaw/bin/gh
	ln -sfnv $(abspath $|) $@

~/.claude/skills: | $(MYFILES)/os/arch/.claude/skills
	ln -sfnv $(abspath $|) $@

~/.codex/skills: | $(MYFILES)/os/arch/.codex/skills
	ln -sfnv $(abspath $|) $@
