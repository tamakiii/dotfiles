.PHONY: help install dependencies clean
.PHONY: brew dotfiles zsh tmux vim npm

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	vendor \
	brew \
	dotfiles \
	zsh \
	tmux \
	vim \
	npm

dependencies:
	type make > /dev/null

brew:
	[[ "$$OSTYPE" == "darwin"* ]] && $(MAKE) -f brew.mk install || true

dotfiles:
	$(MAKE) -f dotfiles.mk install

zsh:
	$(MAKE) -f zsh.mk install

tmux:
	$(MAKE) -f tmux.mk install

vim:
	$(MAKE) -f vim.mk install

npm:
	$(MAKE) -f npm.mk install

vendor:
	mkdir $@

clean:
	rm -rf vendor
	$(MAKE) -f dotfiles.mk clean
	$(MAKE) -f zsh.mk clean
	$(MAKE) -f tmux.mk clean
	$(MAKE) -f vim.mk clean
	$(MAKE) -f npm.mk clean
