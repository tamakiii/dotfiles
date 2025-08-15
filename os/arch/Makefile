.PHONY: help check check-dependency install uninstall backup-packages restore-packages

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
	test -f /etc/systemd/system/wol@.service
	test -f /etc/systemd/network/20-ethernet.network
	systemctl is-enabled wol@eno1.service

check-dependency:
	which zsh > /dev/null || $(error Please install zsh)
	which tmux > /dev/null || $(error Please install tmux)
	which hx > /dev/null || $(error Please install hx)
	which ghostty > /dev/null || $(error Please install ghostty)
	which fzf > /dev/null || $(error Please install fzf)
	which blueman-applet > /dev/null || $(error Please install blueman-applet)
	which overskride > /dev/null || $(error Please install overskride)
	which shairport-sync > /dev/null || $(error Please install shairport-sync)
	which avahi-daemon > /dev/null || $(error Please install avahi)
	which mpv > /dev/null || $(error Please install mpv)
	which ethtool > /dev/null || $(error Please install ethtool)

backup-packages: \
	pkglist.txt

restore-packages: | pkglist.txt
	sudo pacman -S --needed - < $|

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
	~/.config/shairport-sync.conf \
	/etc/systemd/system/wol@.service \
	/etc/systemd/network/20-ethernet.network \
	wol@eno1.service-enabled

uninstall:
	sudo systemctl disable wol@eno1.service
	sudo rm -vf /etc/systemd/network/20-ethernet.network
	sudo rm -vf /etc/systemd/system/wol@.service
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

/etc/systemd/system/wol@.service: etc/systemd/system/wol@.service
	sudo cp $< $@

/etc/systemd/network/20-ethernet.network: etc/systemd/network/20-ethernet.network
	sudo cp $< $@
	sudo systemctl restart systemd-networkd

wol@eno1.service-enabled: /etc/systemd/system/wol@.service
	sudo systemctl daemon-reload
	sudo systemctl enable wol@eno1.service
	sudo systemctl start wol@eno1.service
	touch $@

pkglist.txt:
	pacman -Qe > pkglist.txt
