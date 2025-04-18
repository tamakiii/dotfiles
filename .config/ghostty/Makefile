.PHONY: help diff

SHELL := bash

help:
	@cat $(firstword $(MAKEFILE_LIST))

diff: config
	diff -u --color <(ghostty +show-config --default --docs) $<
