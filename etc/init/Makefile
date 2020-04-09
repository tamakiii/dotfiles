.PHONY: help dep install uninstall setup clean

DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/../..)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(lastword $(MAKEFILE_LIST)) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

dep:
	@type fzf > /dev/null
	@type vim > /dev/null
	@type tmux > /dev/null

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
	~/.bash/plugin/fzf-tab-completion \
	~/.vim/backup \
	~/.vim/swapfile \
	~/.vim/undo

~/.local/bin/bpkg:
	curl -sLo- http://get.bpkg.sh | bash

~/.tmux/plugin/tpm:
	git clone https://github.com/tmux-plugin/tpm $@

~/.bash/plugin/fzf-tab-completion: ~/.bash/plugin
	git clone git@github.com:lincheney/fzf-tab-completion.git $@

~/.bash/plugin: ~/.bash
	mkdir -p $@

~/.bash:
	mkdir -p $@

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
