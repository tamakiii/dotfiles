
install:
	sudo apt install -y \
	  openssh-server \
	  nfs-common \
	  git \
	  vim \
	  zsh \
	  tmux \
	  openssh-server \
	  apt-transport-https \
	  ca-certificates \
	  curl \
	  software-properties-common
	sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	sudo add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-xenial main"
	sudo apt update
	sudo apt-get install docker-engine docker docker-compose

before:
	@echo "execute: sudo apt install make"
