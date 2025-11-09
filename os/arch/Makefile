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
	test -L ~/.config/rofi
	test -d ~/.config/autostart
	test -L ~/.config/autostart/blueman-applet.desktop
	test -L ~/.config/autostart/overskride.desktop
	test -L ~/.config/git
	test -d ~/.config/systemd
	test -d ~/.config/systemd/user
	test -L ~/.config/systemd/user/shairport-sync.service
	test -L ~/.config/shairport-sync.conf

check-dependency:
	@which zsh > /dev/null || (echo "Please install zsh" && exit 1)
	@which tmux > /dev/null || (echo "Please install tmux" && exit 1)
	@which hx > /dev/null || (echo "Please install hx" && exit 1)
	@which ghostty > /dev/null || (echo "Please install ghostty" && exit 1)
	@which fzf > /dev/null || (echo "Please install fzf" && exit 1)
	@which rofi > /dev/null || (echo "Please install rofi" && exit 1)
	@which blueman-applet > /dev/null || (echo "Please install blueman-applet" && exit 1)
	@which overskride > /dev/null || (echo "Please install overskride" && exit 1)
	@which mpv > /dev/null || (echo "Please install mpv" && exit 1)
	@which shairport-sync > /dev/null || (echo "Please install shairport-sync" && exit 1)
	@which avahi-daemon > /dev/null || (echo "Please install avahi" && exit 1)

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
	~/.config/rofi \
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
	rm -vrf ~/.config/rofi
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

~/.config/rofi: .config/rofi ~/.config
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

pkglist.txt:
	pacman -Qe > pkglist.txt
