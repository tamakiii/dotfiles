.PHONY: help install clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	npm install

clean:
	rm -rf node_modules
