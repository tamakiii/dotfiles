.PHONY: help install check check-dependency uninstall

SHELL := bash --noprofile --norc -eo pipefail

error-install := echo "[error] install '$$_'"; exit 1;
check-dependency = which $(1) || { $(call error-install) }

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	~/.config/autostart \
	~/.config/autostart/blueman-applet.desktop \
	~/.config/autostart/overskride.desktop

check:
	test -d ~/.config/autostart
	test -L ~/.config/autostart/blueman-applet.desktop
	test -L ~/.config/autostart/overskride.desktop

check-dependency:
	@$(call check-dependency,blueman-applet)
	@$(call check-dependency,overskride)

uninstall:
	rm -vrf ~/.config/autostart/blueman-applet.desktop
	rm -vrf ~/.config/autostart/overskride.desktop

~/.config/autostart:
	mkdir -p $@

~/.config/autostart/blueman-applet.desktop: .config/autostart/blueman-applet.desktop ~/.config/autostart
	ln -sfnv $(abspath $<) $@

~/.config/autostart/overskride.desktop: .config/autostart/overskride.desktop ~/.config/autostart
	ln -sfnv $(abspath $<) $@