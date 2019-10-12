make -C ~/.dotfiles/etc/init
make -f ~/.dotfiles/config.mk

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX
  make -f ~/.dotfiles/brew.mk
fi
