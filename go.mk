.PHONY: help

export GO111MODULE := off
export GOBIN := $(PWD)/bin

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	go install .
