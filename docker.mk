.PHONY: help build login clean

IMAGE := tamakiii/dotfiles
SHELL := bash

help:
	@cat $(firstword $(MAKEFILE_LIST))

build:
	docker build -t $(IMAGE) .

login:
	docker run -it --rm -v $(shell pwd):/root/.dotfiles -w /root $(IMAGE) $(SHELL)

clean:
	docker image rm $(IMAGE)
