.PHONY: help install clean

SHELL := bash
OS_NAME := $(shell source ./os.sh | grep -e '^NAME=' | awk -F= '{ print $$2 }')
OS_VERSION := $(shell source ./os.sh | grep -e '^VERSION=' | awk -F= '{ print $$2 }')

MAKEFILE :=
ifeq ($(OS_NAME),Darwin)
	MAKEFILE := macos.mk
endif
ifeq ($(OS_NAME),Debian GNU/Linux)
	MAKEFILE := debian.mk
endif

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	make -f $(MAKEFILE) $@

clean:
	make -f $(MAKEFILE) $@
