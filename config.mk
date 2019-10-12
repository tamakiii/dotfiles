ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: \
	~/.config \
	~/.config/git \
	~/.config/git/config \
	~/.config/fish \
	~/.config/fish/config.fish \
	~/.config/fish/fishfile \
	~/.config/fish/fish_variables

~/.config/git/config:
	cp $(ROOT_DIR)/$(subst $(HOME)/,,$@) $@

~/.config/fish/config.fish:
	ln -s $(ROOT_DIR)/$(subst $(HOME)/,,$@) $@

~/.config/fish/fishfile:
	ln -s $(ROOT_DIR)/$(subst $(HOME)/,,$@) $@

~/.config/fish/fish_variables:
	ln -s $(ROOT_DIR)/$(subst $(HOME)/,,$@) $@

~/.config/fish:
	mkdir -p $@

~/.config/git:
	mkdir -p $@

~/.config:
	mkdir -p $@

clean:
	cp -r ~/.config $(shell mktemp -d)
	rm -rf ~/.config/git/config
	rm -rf ~/.config/fish/config.fish
	rm -rf ~/.config/fish/fishfile
	rm -rf ~/.config/fish/fish_variables

