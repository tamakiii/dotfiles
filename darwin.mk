.PHONY: help install

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	echo "Hello, Darwin"
