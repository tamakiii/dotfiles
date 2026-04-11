.PHONY: help install uninstall check
.PHONY: install-packages check-packages

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zprofile \
	~/.config/ghostty/config \
	~/.local/bin/github-mcp-headers \
	~/.local/bin/gw

uninstall:
	rm -rf ~/.local/bin/gw
	rm -rf ~/.local/bin/github-mcp-headers
	rm -f ~/.config/ghostty/config
	rm -rf ~/.zprofile

check:
	@err=0; \
	for link in \
		~/.zprofile ~/.config/ghostty/config \
		~/.local/bin/github-mcp-headers ~/.local/bin/gw \
	; do \
		if [ ! -e "$$link" ]; then \
			echo "BROKEN: $$link"; err=1; \
		fi; \
	done; \
	exit $$err

~/.zprofile: | .zprofile
	ln -sfnv $(abspath $|) $@

~/.config/ghostty/config: | .config/ghostty/config
	ln -sfnv $(abspath $|) $@

~/.local/bin/github-mcp-headers: | bin/github-mcp-headers
	ln -sfnv $(abspath $|) $@

~/.local/bin/gw: | bin/gw
	ln -sfnv $(abspath $|) $@

install-packages: Brewfile
	brew bundle --file=$<

check-packages: Brewfile
	brew bundle check --file=$<
