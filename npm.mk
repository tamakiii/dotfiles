.PHONY: help install

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	npm install
