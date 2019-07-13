.PHONY: all dependencies

ROOT_DIR := $(HOME)/Sites
ORGANIZATION :=
REPOSITORY :=
TARGET := $(ROOT_DIR)/$(ORGANIZATION)/$(REPOSITORY)

all: dependencies \
		$(ROOT_DIR)/$(ORGANIZATION) \
		$(TARGET) \
		$(TARGET)/README.md \
		$(TARGET)/.git \
		$(TARGET)/.git/index \
		$(TARGET)/.git/config \
		$(TARGET)/.git/refs/remotes/origin
	cd $(TARGET)

dependencies:
	type hub > /dev/null
	type git > /dev/null

$(ROOT_DIR)/%:
	make -f $(lastword $(MAKEFILE_LIST)) \
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
