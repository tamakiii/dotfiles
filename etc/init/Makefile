all:
	cat $(realpath $(lastword $(MAKEFILE_LIST)))

install: \
	$(HOME)/.zplugin \
	$(HOME)/.vim/autoload/plug.vim

$(HOME)/.zplugin:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

$(HOME)/.vim/autoload/plug.vim:
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

