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
	~/.claude/CLAUDE.md \
	~/.claude/settings.json \
	~/.claude/commands \
	~/.config/claude \
	~/.config/claude/mcp.json \
	uv.lock
	$(MAKE) -C os/macos install

check:
	test -L ~/.claude/CLAUDE.md
	test -L ~/.claude/settings.json
	test -L ~/.claude/commands
	test -d ~/.config/claude
	test -f ~/.config/claude/mcp.json
	test -f uv.lock
	$(MAKE) -C os/macos check

check-dependency:
	@$(call check-dependency,uv)
	$(MAKE) -C os/macos check-dependency

uninstall:
	rm -vrf ~/.claude/commands
	rm -vrf ~/.claude/settings.json
	rm -vrf ~/.claude/CLAUDE.md
	rm -vrf ~/.config/claude/mcp.json
	rm -vrf ~/.config/claude
	rm -rf uv.lock
	$(MAKE) -C os/macos uninstall

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

~/.config:
	mkdir -p $@

~/.config/claude: ~/.config
	mkdir -p $@

~/.config/claude/mcp.json: .config/claude/mcp.json ~/.config/claude
	envsubst < $< > $@

uv.lock: pyproject.toml
	uv lock
