.PHONY: @help

@help:
	@echo "Secret makefile - contains sensitive configuration"

# Detect operating system
OS_NAME := $(shell uname)

# Include macOS-specific secrets if on macOS
ifeq ($(OS_NAME),Darwin)
include makefiles/include/secret.macos.mk
endif
