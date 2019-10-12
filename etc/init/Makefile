all: \
	~/.config/fish/functions/fisher.fish \
	~/.zplugin \
	~/.vim/autoload/plug.vim \
	install

install:
	fisher

~/.config/fish/functions/fisher.fish:
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

~/.zplugin:
	sh -c "$(shell curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

~/.vim/autoload/plug.vim:
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

