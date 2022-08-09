.PHONY: help build sh clean

IMAGE := tamakiii/dotfiles
CMD :=

help:
	@cat $(firstword $(MAKEFILE_LIST))

build:
	docker build -t $(IMAGE) .

sh:
	docker run -it --rm -v $(shell pwd):/root/.dotfiles -w /root $(IMAGE) $(CMD)

clean:
	docker image rm $(IMAGE)
