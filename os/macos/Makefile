.PHONY: install check uninstall

SHELL := bash --noprofile --norc -eo pipefail

# Shared functions and variables
error-install := echo \"[error] install '$$_'\"; exit 1;
check-dependency = which $(1) || { $(call error-install) }

# macOS-specific installation targets
install: \
	.zsh \
	.zsh/antigen.zsh \
	~/.zsh \
	~/.zshrc \
	~/.zprofile \
	~/.config \
	~/.config/tmux \
	~/.config/helix \
	~/.config/ghostty \
	$(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json

# macOS-specific check targets
check:
	test -L ~/.zsh
	test -L ~/.zshrc
	test -f ~/.zprofile
	test -L ~/.config/tmux
	test -L ~/.config/helix
	test -L ~/.config/ghostty
	test -f $(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json

# macOS-specific dependency checks
check-dependency:
	@$(call check-dependency,zsh)
	@$(call check-dependency,tmux)
	@$(call check-dependency,fzf)
	@$(call check-dependency,hx)

# macOS-specific uninstall
uninstall:
	rm -vfr $(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json
	rm -vrf ~/.config/helix
	rm -vrf ~/.config/tmux
	rm -vrf ~/.config/ghostty
	rm -rf ~/.zprofile
	rm -rf ~/.zshrc
	rm -rf ~/.zsh
	rm -rf .zsh

# macOS-specific targets
.zsh:
	mkdir $@

.zsh/antigen.zsh:
	curl -L git.io/antigen > $@

~/.zsh: .zsh
	ln -sfnv $(abspath $<) $@

~/.zshrc: .zshrc
	ln -sfnv $(abspath $<) $@

~/.zprofile: os/macos/.zprofile
	envsubst < $< > $@

~/.config:
	mkdir -p $@

~/.config/tmux: .config/tmux
	ln -sfnv $(abspath $<) $@

~/.config/helix: .config/helix
	ln -sfnv $(abspath $<) $@

~/.config/ghostty: .config/ghostty
	ln -sfnv $(abspath $<) $@

$(HOME)/Library/Application\ Support/Claude/claude_desktop_config.json: Library/Application\ Support/Claude/claude_desktop_config.json
	envsubst < "$<" > "$@"