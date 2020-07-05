.PHONY: help install dependencies clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	vendor \
	local \
	build

build:
	[[ "$$OSTYPE" == "darwin"* ]] && [[ "$$SKIP_BREW" != "1" ]] && \
		$(MAKE) -f brew.mk install
	$(MAKE) -f dotfiles.mk install

dependencies:
	type make > /dev/null

vendor:
	mkdir $@

local:
	mkdir $@

clean:
	rm -rf vendor
	rm -rf local
	[[ "$$OSTYPE" == "darwin"* ]] && [[ "$$SKIP_BREW" != "1" ]] && \
		$(MAKE) -f brew.mk clean
	$(MAKE) -f dotfiles.mk clean
