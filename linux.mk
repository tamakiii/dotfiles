SHELL := bash

.PHONY: install/dotfiles clean/dotfiles
install/dotfiles: dotfiles.mk
	$(MAKE) -f $< install
clean/dotfiles: dotfiles.mk
	$(MAKE) -f $< clean

.PHONY: install/zsh clean/zsh
install/zsh: zsh.mk
	$(MAKE) -f $< install
clean/zsh: zsh.mk
	$(MAKE) -f $< clean

.PHONY: install/tmux clean/tmux
install/tmux: tmux.mk
	$(MAKE) -f $< install
clean/tmux: tmux.mk
	$(MAKE) -f $< clean

.PHONY: isntall/vim clean/vim
install/vim: vim.mk
	$(MAKE) -f $< install
clean/vim: vim.mk
	$(MAKE) -f $< clean

.PHONY: install/npm clean/npm
install/npm: npm.mk
	$(MAKE) -f $< install
clean/npm: npm.mk
	$(MAKE) -f $< clean
