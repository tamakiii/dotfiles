.PHONY: help install update clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install:
	apt install -y tmux git vim

update:
	apt update

clean:
	apt clean
