.PHONY: help install uninstall check

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zshenv \
	~/.zprofile \
	~/.config/ghostty/config \
	~/.local/bin/github-mcp-headers \
	~/.local/bin/gw

uninstall:
	rm -rf ~/.local/bin/gw
	rm -rf ~/.local/bin/github-mcp-headers
	rm -f ~/.config/ghostty/config
	rm -rf ~/.zprofile
	rm -rf ~/.zshenv

check:
	@err=0; \
	for link in \
		~/.zshenv ~/.zprofile ~/.config/ghostty/config \
		~/.local/bin/github-mcp-headers ~/.local/bin/gw \
	; do \
		if [ ! -e "$$link" ]; then \
			echo "BROKEN: $$link"; err=1; \
		fi; \
	done; \
	exit $$err

~/.zshenv: | .zshenv
	ln -sfnv $(abspath $|) $@

~/.zprofile: | .zprofile
	ln -sfnv $(abspath $|) $@

~/.config/ghostty/config: | .config/ghostty/config
	ln -sfnv $(abspath $|) $@

~/.local/bin/github-mcp-headers: | bin/github-mcp-headers
	ln -sfnv $(abspath $|) $@

~/.local/bin/gw: | bin/gw
	ln -sfnv $(abspath $|) $@
