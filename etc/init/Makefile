all: \
	/usr/local/bin/brew \
	~/.config/fish/functions/fisher.fish \
	~/.zplugin \
	~/.vim/autoload/plug.vim \
	install

install:
	fish -c "fisher"

/usr/local/bin/brew:
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

~/.config/fish/functions/fisher.fish:
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

~/.zplugin:
	sh -c "$(shell curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

~/.vim/autoload/plug.vim:
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

