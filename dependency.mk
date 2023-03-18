.PHONY: help setup install
.PHONY: teardown uninstall

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependency/artempyanykh/marksman

install:
	make -C dependency/artempyanykh/marksman install

dependency/artempyanykh/marksman: | dependency
	git clone https://github.com/artempyanykh/marksman.git $@

dependency:
	mkdir -p $@

teardown:
	rm -rf dependency

uninstall:
	//
