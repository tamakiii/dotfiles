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
	type brew > /dev/null

setup:
	brew install zsh
	brew install vim
	brew install tmux
	brew install git
	brew install ssh
	brew install curl
	brew install npm

.PHONY: install/brew clean/brew
install/brew: brew.mk
	$(MAKE) -f $< install
clean/brew: brew.mk
	$(MAKE) -f $< clean

clean: \
	clean/zsh \
	clean/tmux \
	clean/vim \
	clean/npm \
	clean/dotfiles
