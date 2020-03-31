.PHONY: help install uninstall setup clean

DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/../..)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(lastword $(MAKEFILE_LIST)) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: setup ## Install
	vim -E -s -u ~/.vimrc +PlugInstall +qall
	~/.tmux/plugins/tpm/tpm
	/usr/local/opt/fzf/install \
		--no-zsh \
		--no-fish \
		--key-bindings \
		--completion \
		--update-rc

uninstall:
	/usr/local/opt/fzf/uninstall

setup: \
	~/.local/bin/bpkg \
	~/.tmux/plugins/tpm \
	~/.vim/backup \
	~/.vim/swapfile \
	~/.vim/undo

~/.local/bin/bpkg:
	curl -Lo- "https://raw.githubusercontent.com/bpkg/bpkg/master/setup.sh" | bash

~/.tmux/plugins/tpm:
	git clone https://github.com/tmux-plugins/tpm $@

~/.vim/backup:
	mkdir -p $@

~/.vim/swapfile:
	mkdir -p $@

~/.vim/undo:
	mkdir -p $@

clean:
	rm -rf ~/.local/bin/bpkg
	rm -rf ~/.tmux/plugins/tpm
	rm -rf ~/.vim/backup
	rm -rf ~/.vim/swapfile
	rm -rf ~/.vim/undo
