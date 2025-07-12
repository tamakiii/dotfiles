.PHONY: help build clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

build: \
	bin \
	bin/git-url

clean:
	rm -rf bin

bin:
	mkdir -p bin

bin/git-url: main.go go.mod
	go build -o bin/git-url .
