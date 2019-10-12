DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DOTDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))/../..))
MAKE := $(shell which make)

install: \
	install/bundle \
	make -f $(DIR)/make/mac/brew.mk

install/bundle:
	@type bundle > /dev/null
	@bundle install

clean:
	make -f $(DIR)/make/mac/brew.mk
