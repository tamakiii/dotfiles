DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DOTDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))/../..))
MAKE := $(shell which make)

install:
	make -f $(DIR)/make/mac/brew.mk

clean:
	make -f $(DIR)/make/mac/brew.mk
