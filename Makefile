.PHONY: help install dependencies brew build deploy test update clean

.DEFAULT_GOAL := help

DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

install: \
	dependencies \
	brew \
	build \
	deploy

dependencies:
	type grep > /dev/null
	type sort > /dev/null
	type awk > /dev/null

brew:
	 -$(MAKE) -f brew.mk install

build:
	$(MAKE) -f build.mk install

update: 
	$(MAKE) -f build.mk update

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

deploy: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

test: ## Test dotfiles and init scripts
	@#DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/test/test.sh
	@echo "test is inactive temporarily"

clean: ## Remove the dot files and this repo
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	$(MAKE) -f build.mk clean

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
