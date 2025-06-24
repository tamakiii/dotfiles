.PHONY: help install check check-dependency uninstall

SHELL := bash --noprofile --norc -eo pipefail
error-install := echo "[error] install '$$_'"; exit 1;
check-dependency = which $(1) || { $(call error-install) }

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
	~/.claude/CLAUDE.md

check:
	test -L ~/.zsh
	test -L ~/.zshrc
	test -L ~/.config/tmux
	test -L ~/.config/helix
	test -L ~/.claude/CLAUDE.md

check-dependency:
	@$(call check-dependency,zsh)
	@$(call check-dependency,tmux)
	@$(call check-dependency,uv)
	@$(call check-dependency,fzf)
	@$(call check-dependency,hx)

uninstall:
	rm -vrf ~/.claude/CLAUDE.md
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
	mkdir $@

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
