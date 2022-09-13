.PHONY: help install update clean
.PHONY: install-packages install-locales install-shell

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: install-packages install-locales install-shell
	$(MAKE) -f vim.mk install

install-packages:
	apt install -y --no-install-recommends \
	  tmux \
	  git \
	  vim \
	  curl \
	  ca-certificates \
	  zsh \
	  locales \
	  less \
	  man

install-locales: \
	/usr/share/i18n \
	/usr/lib/locale/en_US.UTF-8

install-shell: | /etc/shells /etc/passwd
	chsh -s $(shell which zsh)

/usr/share/i18n:
	locale-gen

/usr/lib/locale/en_US.UTF-8: | /usr/share/i18n/locales/en_US
	localedef -i $| -f UTF-8 $@

update:
	apt update

clean:
	apt clean
