.PHONY: help check check-dependency install uninstall install-packages sync-packages lock-packages audit add-package remove-package update-packages

SHELL := bash --noprofile --norc -eo pipefail

help:
	@cat $(firstword $(MAKEFILE_LIST))

check:
	test -L ~/.zsh
	test -L ~/.zshrc
	test -f ~/.zprofile
	test -d ~/.config
	test -L ~/.config/tmux
	test -L ~/.config/helix
	test -L ~/.config/ghostty
	test -d ~/.config/autostart
	test -L ~/.config/autostart/blueman-applet.desktop
	test -L ~/.config/autostart/overskride.desktop
	test -L ~/.config/git
	test -d ~/.config/systemd
	test -d ~/.config/systemd/user
	test -L ~/.config/systemd/user/shairport-sync.service
	test -L ~/.config/shairport-sync.conf

check-dependency:
	@echo "Checking dependencies against manifest..."
	@../../dependencies/arch-check

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
	~/.config/autostart \
	~/.config/autostart/blueman-applet.desktop \
	~/.config/autostart/overskride.desktop \
	~/.config/git \
	~/.config/systemd \
	~/.config/systemd/user \
	~/.config/systemd/user/shairport-sync.service \
	~/.config/shairport-sync.conf

uninstall:
	rm -vrf ~/.config/shairport-sync.conf
	rm -vrf ~/.config/systemd/user/shairport-sync.service
	rm -vrf ~/.config/git
	rm -vrf ~/.config/autostart/blueman-applet.desktop
	rm -vrf ~/.config/autostart/overskride.desktop
	rm -vrf ~/.config/ghostty
	rm -vrf ~/.config/helix
	rm -vrf ~/.config/tmux
	rm -rf ~/.zprofile
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

~/.config/tmux: .config/tmux ~/.config
	ln -sfnv $(abspath $<) $@

~/.config/helix: .config/helix ~/.config
	ln -sfnv $(abspath $<) $@

~/.config/ghostty: .config/ghostty ~/.config
	ln -sfnv $(abspath $<) $@

~/.config/autostart:
	mkdir -p $@

~/.config/autostart/blueman-applet.desktop: .config/autostart/blueman-applet.desktop ~/.config/autostart
	ln -sfnv $(abspath $<) $@

~/.config/autostart/overskride.desktop: .config/autostart/overskride.desktop ~/.config/autostart
	ln -sfnv $(abspath $<) $@

~/.config/git: .config/git ~/.config
	ln -sfnv $(abspath $<) $@

~/.config/systemd:
	mkdir -p $@

~/.config/systemd/user: ~/.config/systemd
	mkdir -p $@

~/.config/systemd/user/shairport-sync.service: .config/systemd/user/shairport-sync.service ~/.config/systemd/user
	ln -sfnv $(abspath $<) $@

~/.config/shairport-sync.conf: .config/shairport-sync.conf ~/.config
	ln -sfnv $(abspath $<) $@

~/.zprofile: .zprofile
	cp $< $@

# Package Management Targets
# These targets provide Cargo-like dependency management for Arch Linux packages

install-packages:
	@echo "Installing packages from manifest..."
	@../../dependencies/arch-install

sync-packages:
	@echo "Synchronizing system packages to match manifest..."
	@../../dependencies/arch-sync

lock-packages:
	@echo "Generating lock file from current system state..."
	@../../dependencies/arch-lock

audit:
	@echo "Auditing packages for security updates and unused packages..."
	@../../dependencies/arch-audit

add-package:
	@test -n "$(PACKAGE)" || (echo "Usage: make add-package PACKAGE=package-name [SOURCE=aur]" && exit 1)
	@echo "Adding package $(PACKAGE) to manifest and installing..."
	@../../dependencies/arch-add "$(PACKAGE)" "$(SOURCE)"

remove-package:
	@test -n "$(PACKAGE)" || (echo "Usage: make remove-package PACKAGE=package-name" && exit 1)
	@echo "Removing package $(PACKAGE) from manifest and system..."
	@../../dependencies/arch-remove "$(PACKAGE)"

update-packages:
	@echo "Updating packages and regenerating lock file..."
	@sudo pacman -Syu --noconfirm
	@../../dependencies/arch-lock
