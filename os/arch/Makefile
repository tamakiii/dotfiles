.PHONY: help check check-dependency install uninstall

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
	test -d ~/.config/hypr
	test -L ~/.config/hypr/hyprland.conf
	test -L ~/.config/hypr/hyprpaper.conf
	test -L ~/.config/hypr/hyprlock.conf
	test -d ~/.config/waybar
	test -L ~/.config/waybar/config
	test -L ~/.config/waybar/style.css
	test -d ~/.config/waybar/scripts

check-dependency:
	@which zsh > /dev/null || (echo "Please install zsh" && exit 1)
	@which tmux > /dev/null || (echo "Please install tmux" && exit 1)
	@which helix > /dev/null || (echo "Please install hx" && exit 1)
	@which ghostty > /dev/null || (echo "Please install ghostty" && exit 1)
	@which fzf > /dev/null || (echo "Please install fzf" && exit 1)
	@which rofi > /dev/null || (echo "Please install rofi" && exit 1)
	@which blueman-applet > /dev/null || (echo "Please install blueman-applet" && exit 1)
	@which mpv > /dev/null || (echo "Please install mpv" && exit 1)
	@which shairport-sync > /dev/null || (echo "Please install shairport-sync" && exit 1)
	@which avahi-daemon > /dev/null || (echo "Please install avahi" && exit 1)
	@which Hyprland > /dev/null || (echo "Please install hyprland" && exit 1)
	@which waybar > /dev/null || (echo "Please install waybar" && exit 1)
	@which hyprpaper > /dev/null || (echo "Please install hyprpaper" && exit 1)
	@which grim > /dev/null || (echo "Please install grim" && exit 1)
	@which slurp > /dev/null || (echo "Please install slurp" && exit 1)
	@which wl-copy > /dev/null || (echo "Please install wl-clipboard" && exit 1)
	@which brightnessctl > /dev/null || (echo "Please install brightnessctl" && exit 1)

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
	~/.config/hypr \
	~/.config/hypr/hyprland.conf \
	~/.config/hypr/hyprpaper.conf \
	~/.config/hypr/hyprlock.conf \
	~/.config/waybar \
	~/.config/waybar/config \
	~/.config/waybar/style.css \
	~/.config/waybar/scripts \

uninstall:
	rm -vrf ~/.config/waybar/scripts
	rm -vrf ~/.config/waybar/style.css
	rm -vrf ~/.config/waybar/config
	rm -vrf ~/.config/hypr/hyprlock.conf
	rm -vrf ~/.config/hypr/hyprpaper.conf
	rm -vrf ~/.config/hypr/hyprland.conf
	rm -vrf ~/.config/shairport-sync.conf
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

~/.config/hypr: ~/.config
	mkdir -p $@

~/.config/hypr/hyprland.conf: .config/hypr/hyprland.conf ~/.config/hypr
	ln -sfnv $(abspath $<) $@

~/.config/hypr/hyprpaper.conf: .config/hypr/hyprpaper.conf ~/.config/hypr
	ln -sfnv $(abspath $<) $@

~/.config/hypr/hyprlock.conf: .config/hypr/hyprlock.conf ~/.config/hypr
	ln -sfnv $(abspath $<) $@

~/.config/waybar: ~/.config
	mkdir -p $@

~/.config/waybar/config: .config/waybar/config ~/.config/waybar
	ln -sfnv $(abspath $<) $@

~/.config/waybar/style.css: .config/waybar/style.css ~/.config/waybar
	ln -sfnv $(abspath $<) $@

~/.config/waybar/scripts: .config/waybar/scripts ~/.config/waybar
	ln -sfnv $(abspath $<) $@

~/.zprofile: .zprofile
	cp $< $@
