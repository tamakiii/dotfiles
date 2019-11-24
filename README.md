# dotfiles

## How to use

~~~sh
ssh-keygen -t rsa -b 4096
cat ~/.ssh/id_rsa.pub | pbcopy
open "https://github.com/settings/keys" # New SSH key
~~~
~~~sh
git clone git@github.com:tamakiii/dotfiles.git ~/.dotfiles
make -C ~/.dotfiles install
~~~
