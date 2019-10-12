all: \
	~/.config/fish/functions/fisher.fish \
	~/.zplugin \
	~/.vim/autoload/plug.vim

~/.config/fish/functions/fisher.fish:
	sh -c "$(curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher)"

~/.zplugin:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

~/.vim/autoload/plug.vim:
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

