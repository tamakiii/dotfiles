.PHONY: help install dependencies build clean

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	.zsh/vendor/autosuggestions \
	.zsh/vendor/zsh-syntax-highlighting

dependencies:
	@type zsh > /dev/null

.zsh/vendor/autosuggestions: .zsh/vendor
	[[ -d $@ ]] || git clone https://github.com/zsh-users/zsh-autosuggestions.git $@

.zsh/vendor/zsh-syntax-highlighting: .zsh/vendor
	[[ -d $@ ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $@

.zsh/vendor: .zsh
	mkdir -p $@

.zsh:
	mkdir -p $@

clean:
	rm r-f .zsh/vendor
