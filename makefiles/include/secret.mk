.PHONY: @help

@help:
	@echo "Secret makefile - contains sensitive configuration"

# Detect operating system
OS_NAME := $(shell uname)

# Map OS names to directory names
ifeq ($(OS_NAME),Darwin)
OS_DIR := macos
else ifeq ($(OS_NAME),Linux)
OS_DIR := arch
else
OS_DIR := 
endif

# Include OS-specific secrets if available
ifneq ($(OS_DIR),)
OS_SECRET_FILE := os/$(OS_DIR)/makefiles/secret.mk
ifeq ($(shell test -f $(OS_SECRET_FILE) && echo exists),exists)
include $(OS_SECRET_FILE)
else
# Default empty values if no OS-specific secrets file
GITHUB_PERSONAL_ACCESS_TOKEN =
DISCORD_CHANNEL_ID_CLAUDE =
DISCORD_USER_ID =
DISCORD_TOKEN =
endif
else
# Default empty values for unknown OS
GITHUB_PERSONAL_ACCESS_TOKEN =
DISCORD_CHANNEL_ID_CLAUDE =
DISCORD_USER_ID =
DISCORD_TOKEN =
endif
