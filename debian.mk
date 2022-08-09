.PHONY: help install install-packages update clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: install-packages
	$(MAKE) -f vim.mk install

install-packages:
	apt install -y --no-install-recommends \
	  tmux \
	  git \
	  vim \
	  curl \
	  ca-certificates \
	  man

update:
	apt update

clean:
	apt clean
