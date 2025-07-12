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

bin/git-url: git-url/main.go git-url/go.mod
	cd git-url && go build -o ../bin/git-url .
