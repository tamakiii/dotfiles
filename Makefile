.PHONY: help install check check-dependency uninstall

SHELL := bash --noprofile --norc -eo pipefail

include makefiles/include/secret.mk

export GITHUB_PERSONAL_ACCESS_TOKEN ?= $(GITHUB_PERSONAL_ACCESS_TOKEN)
export DISCORD_CHANNEL_ID ?= $(DISCORD_CHANNEL_ID_CLAUDE)
export DISCORD_USER_ID ?= $(DISCORD_USER_ID)
export DISCORD_TOKEN ?= $(DISCORD_TOKEN)

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	.venv \
	~/.claude/CLAUDE.md \
	~/.claude/settings.json \
	~/.claude/commands \
	~/.claude/agents \
	~/.config/claude \
	~/.config/claude/mcp.json

check:
	test -d .venv
	test -L ~/.claude/CLAUDE.md
	test -L ~/.claude/settings.json
	test -L ~/.claude/commands
	test -L ~/.claude/agents
	test -d ~/.config/claude
	test -f ~/.config/claude/mcp.json

check-dependency:
	which uv > /dev/null || $(error Please install uv)

uninstall:
	rm -vrf ~/.config/claude/mcp.json
	rm -vrf ~/.config/claude
	rm -vrf ~/.claude/agents
	rm -vrf ~/.claude/commands
	rm -vrf ~/.claude/settings.json
	rm -vrf ~/.claude/CLAUDE.md
	rm -rf .venv

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

~/.claude/agents: .claude/agents ~/.claude
	ln -sfnv $(abspath $<) $@

~/.config:
	mkdir -p $@

~/.config/claude: ~/.config
	mkdir -p $@

~/.config/claude/mcp.json: .config/claude/mcp.json ~/.config/claude
	envsubst < $< > $@

.venv: pyproject.toml
	uv sync
