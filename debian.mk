.PHONY: help install update clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: update
	apt install -y tmux git

update:
	apt update

clean:
	apt clean
