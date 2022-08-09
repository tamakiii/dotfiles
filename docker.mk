.PHONY: help build bash clean

IMAGE := tamakiii/dotfiles
SHELL := bash

help:
	@cat $(firstword $(MAKEFILE_LIST))

build:
	docker build -t $(IMAGE) .

bash:
	docker run -it --rm -v $(shell pwd):/root/.dotfiles -w /root $(IMAGE) $(SHELL)

clean:
	docker image rm $(IMAGE)
