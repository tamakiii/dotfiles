.PHONY: help install dependencies clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	node_modules

dependencies:
	type node > /dev/null

node_modules:
	npm install

clean:
	rm -rf node_modules
