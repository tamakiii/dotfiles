.PHONY: help install check check-dependency uninstall

SHELL := bash --noprofile --norc -eo pipefail

include makefiles/include/secret.mk
error-install := echo "[error] install '$$_'"; exit 1;
check-dependency = which $(1) || { $(call error-install) }

export GITHUB_PERSONAL_ACCESS_TOKEN ?= $(GITHUB_PERSONAL_ACCESS_TOKEN)
export DISCORD_CHANNEL_ID ?= $(DISCORD_CHANNEL_ID_CLAUDE)
export DISCORD_USER_ID ?= $(DISCORD_USER_ID)
export DISCORD_TOKEN ?= $(DISCORD_TOKEN)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.zsh \
	.zsh/antigen.zsh \
	~/.zsh \
	~/.zshrc \
	~/.config \
	~/.config/tmux \
	~/.config/helix \
	~/.claude/CLAUDE.md \
	~/.claude/settings.json \
	~/.claude/commands \
	~/.config/claude \
	~/.config/claude/mcp.json \
	$(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json

check:
	test -L ~/.zsh
	test -L ~/.zshrc
	test -L ~/.config/tmux
	test -L ~/.config/helix
	test -L ~/.claude/CLAUDE.md
	test -L ~/.claude/settings.json
	test -L ~/.claude/commands
	test -d ~/.config/claude
	test -f ~/.config/claude/mcp.json
	test -f $(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json

check-dependency:
	@$(call check-dependency,zsh)
	@$(call check-dependency,tmux)
	@$(call check-dependency,uv)
	@$(call check-dependency,fzf)
	@$(call check-dependency,hx)

uninstall:
	rm -vfr $(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json
	rm -vrf ~/.claude/commands
	rm -vrf ~/.claude/settings.json
	rm -vrf ~/.claude/CLAUDE.md
	rm -vrf ~/.config/claude/mcp.json
	rm -vrf ~/.config/claude
	rm -vrf ~/.config/helix
	rm -vrf ~/.config/tmux
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

~/.config:
	mkdir -p $@

~/.config/tmux: .config/tmux
	ln -sfnv $(abspath $<) $@

~/.config/helix: .config/helix
	ln -sfnv $(abspath $<) $@

~/.claude:
	mkdir -p $@

# Your home folder (~/.claude/CLAUDE.md), which applies it to all your claude sessions
# https://www.anthropic.com/engineering/claude-code-best-practices#:~:text=in%20child%20directories-,Your%20home%20folder,-(~/.claude/CLAUDE
~/.claude/CLAUDE.md: .claude/CLAUDE.md ~/.claude
	ln -sfnv $(abspath $<) $@

~/.claude/settings.json: .claude/settings.json ~/.claude
	ln -sfnv $(abspath $<) $@

~/.claude/commands: .claude/commands ~/.claude
	ln -sfnv $(abspath $<) $@

~/.config/claude: ~/.config
	mkdir -p $@

~/.config/claude/mcp.json: .config/claude/mcp.json ~/.config/claude
	envsubst < $< > $@

$(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json: Library/Application\ Support/Claude/claude_desktop_config.json
	envsubst < "$<" > "$@"
