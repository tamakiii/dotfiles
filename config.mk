ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: \
	~/.config \
	~/.config/git \
	~/.config/git/config

~/.config/git/config:
	cp $(ROOT_DIR)/$(subst $(HOME)/,,$@) $@

~/.config/git:
	mkdir -p $@

~/.config:
	mkdir -p $@

clean:
	cp -r ~/.config $(shell mktemp -d)
	rm -rf ~/.config/git/config

