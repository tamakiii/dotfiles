.PHONY: help install dependencies clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	build

build:
	[[ "$$OSTYPE" == "darwin"* ]] && [[ "$$SKIP_BREW" != "1" ]] && \
		$(MAKE) -f brew.mk install
	$(MAKE) -f dotfiles.mk install

dependencies:
	type make > /dev/null

clean:
	[[ "$$OSTYPE" == "darwin"* ]] && [[ "$$SKIP_BREW" != "1" ]] && \
		$(MAKE) -f brew.mk clean
	$(MAKE) -f dotfiles.mk clean
