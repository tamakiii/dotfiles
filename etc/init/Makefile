all: \
	/usr/local/bin/brew \
	~/.config/fish/functions/fisher.fish \
	~/.zplugin \
	~/.vim/autoload/plug.vim

sessionmanager: \
	/usr/local/bin/session-manager-plugin

/usr/local/bin/brew:
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

~/.config/fish/functions/fisher.fish:
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

~/.zplugin:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

~/.vim/autoload/plug.vim:
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

/usr/local/bin/session-manager-plugin: /tmp/sessionmanager-bundle.zip
	unzip -o $< -d /tmp && sudo /tmp/sessionmanager-bundle/install -i /usr/local/sessionmanagerplugin -b /usr/local/bin/session-manager-plugin

/tmp/sessionmanager-bundle.zip:
	curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac/sessionmanager-bundle.zip" -o /tmp/sessionmanager-bundle.zip

