.PHONY: help dependencies setup build test bash clean

SHELL := bash
NAME := tamakiii/dotfiles/test
BRANCH := $(shell git -C .. symbolic-ref --short HEAD)

help:
	@cat $(firstword $(MAKEFILE_LIST))

test: vendor/dotfiles
	docker run -it --rm -w /root/dotfiles -v $$(realpath $<):/root/dotfiles $(NAME) make install

setup: \
	dependencies \
	build

build:
	docker build -t $(NAME) .

bash: vendor/dotfiles
	docker run -it --rm -w /root/dotfiles -v $$(realpath $<):/root/dotfiles -v ~/.ssh:/root/.ssh $(NAME) bash -l

vendor/dotfiles:
	[[ -d $@ ]] || git clone -b $(BRANCH) git@github.com:tamakiii/dotfiles.git $@

dependencies:
	@type docker > /dev/null

clean:
	rm -rf vendor/dotfiles
