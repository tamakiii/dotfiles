.PHONY: help install uninstall check

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zprofile \
	~/.config/ghostty/config \
	~/.config/hypr \
	~/.local/bin/pbcopy \
	~/.local/bin/pbpaste

uninstall:
	rm -f ~/.local/bin/pbpaste
	rm -f ~/.local/bin/pbcopy
	rm -rf ~/.config/hypr
	rm -f ~/.config/ghostty/config
	rm -rf ~/.zprofile

check:
	@err=0; \
	for link in \
		~/.zprofile ~/.config/ghostty/config ~/.config/hypr \
		~/.local/bin/pbcopy ~/.local/bin/pbpaste \
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

~/.config/hypr: | .config/hypr
	ln -sfnv $(abspath $|) $@

~/.local/bin/pbcopy: | bin/pbcopy
	ln -sfnv $(abspath $|) $@

~/.local/bin/pbpaste: | bin/pbpaste
	ln -sfnv $(abspath $|) $@
