.PHONY: help build shell clean

IMAGE := tamakiii/dotfiles

help:
	@cat $(firstword $(MAKEFILE_LIST))

build:
	docker build -t $(IMAGE) .

shell:
	docker run -it --rm -v $(shell pwd):/root/.dotfiles -w /root --entrypoint /usr/bin/zsh $(IMAGE) -l

clean:
	docker image rm $(IMAGE)
