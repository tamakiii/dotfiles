# tamakiii/dotfiles

## How to use
```sh
git clone git@github.com:tamakiii/dotfiles.git ~/.dotfiles
make -C ~/.dotfiles install
```

## Run on Docker
```sh
make -f docker.mk build login
make -C ~/.dotfiles install
```
