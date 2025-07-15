.PHONY: help install check check-dependency uninstall

SHELL := bash --noprofile --norc -eo pipefail

check-dependency = which $(1) || $(error [error] install '$(1)')

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.zprofile \
	~/.config/autostart \
	~/.config/autostart/blueman-applet.desktop \
	~/.config/autostart/overskride.desktop

check:
	test -f ~/.zprofile
	test -d ~/.config/autostart
	test -L ~/.config/autostart/blueman-applet.desktop
	test -L ~/.config/autostart/overskride.desktop

check-dependency:
	@$(call check-dependency,zsh)
	@$(call check-dependency,blueman-applet)
	@$(call check-dependency,overskride)

uninstall:
	rm -vrf ~/.config/autostart/blueman-applet.desktop
	rm -vrf ~/.config/autostart/overskride.desktop
	rm -rf ~/.zprofile

~/.config/autostart:
	mkdir -p $@

~/.config/autostart/blueman-applet.desktop: .config/autostart/blueman-applet.desktop ~/.config/autostart
	ln -sfnv $(abspath $<) $@

~/.config/autostart/overskride.desktop: .config/autostart/overskride.desktop ~/.config/autostart
	ln -sfnv $(abspath $<) $@

~/.zprofile: .zprofile
	envsubst < $< > $@