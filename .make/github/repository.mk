.PHONY: dependencies

ROOT_DIR := /Users/tamakiii/Sites
ORGANIZATION_DIR := $(wildcard $(ROOT_DIR)/*)
REPOSITORY_DIR := $(wildcard $(ROOT_DIR)/*/*)

ORGANIZATION :=
REPOSITORY :=
TARGET := $(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY)

all: dependencies \
		$(ROOT_DIR)/$(ORGANIZATION) \
		$(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY) \
		$(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY)/README.md \
		$(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY)/.git \
		$(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY)/.git/index \
		$(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY)/.git/config \
		$(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY)/.git/refs/remotes/origin
	cd $(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY)

dependencies:
	type hub
	type git
	type tput

$(ROOT_DIR)/%:
	make \
		ORGANIZATION=$(word 1,$(subst /, ,$(subst $(ROOT_DIR)/,,$@))) \
		REPOSITORY=$(word 2,$(subst /, ,$(subst $(ROOT_DIR)/,,$@)))

$(ROOT_DIR)/$(ORGANIZATION):
	mkdir $@

$(TARGET):
	mkdir $@

$(TARGET)/README.md:
	echo "# $(REPOSITORY)" > $@

$(TARGET)/.git:
	cd $(TARGET) && git init

$(TARGET)/.git/index:
	cd $(TARGET) && \
		git add . && \
		git commit -m 'init' && \
		git remote add origin git@github.com:$(ORGANIZATION)/$(REPOSITORY).git

$(TARGET)/.git/refs/remotes/origin:
	cd $(TARGET) && hub create "$(ORGANIZATION)/$(REPOSITORY)" && git push

