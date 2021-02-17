include linux.mk

.PHONY: help install pre-install dependencies clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	setup \
	install/dotfiles \
	install/zsh \
	install/tmux \
	install/vim \
	install/npm \
	install/dotfiles

dependencies:
	type apt-get > /dev/null

setup:
	apt-get update
	apt-get install -y --no-install-recommends zsh
	apt-get install -y --no-install-recommends vim
	apt-get install -y --no-install-recommends tmux
	apt-get install -y --no-install-recommends git
	apt-get install -y --no-install-recommends ssh
	apt-get install -y --no-install-recommends curl
	apt-get install -y --no-install-recommends npm
	# more
	apt-get install -y --no-install-recommends ca-certificates
	apt-get install -y --no-install-recommends locales
	localedef -f UTF-8 -i ja_JP ja_JP
	localedef -f UTF-8 -i en_US en_US
	update-locale ja_JP.UTF-8

clean: \
	clean/zsh \
	clean/tmux \
	clean/vim \
	clean/npm \
	clean/dotfiles
