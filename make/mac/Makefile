DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DOTDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))/../..))
MAKE := $(shell which make)

install: \
	install/dotfiles \
	install/bundle \
	install/go \
	install/php
	make -f $(DIR)/make/mac/brew.mk

install/dotfiles: \
	~/.config/git/config

install/bundle:
	@type bundle > /dev/null
	@bundle install

install/go:
	@type go > /dev/null
	@go get -u github.com/golang/dep/cmd/dep
	@go get -u github.com/jesseduffield/lazygit

install/php:
	@type pecl > /dev/null
	@pecl install memcached

clean: \
	clean/go
	make -f $(DIR)/make/mac/brew.mk

clean/go:
	@go clean -i -n github.com/golang/dep/cmd/dep
	@go clean -i -n github.com/jesseduffield/lazygit

~/.config/git/config:
	@cp $(DOTDIR)/etc/.config/git/config $@
	@echo "edit:" $@
