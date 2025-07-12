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

bin/git-url: git-url/bin/git-url
	ln -sf ../git-url/bin/git-url bin/

git-url/bin/git-url:
	make -C git-url build
