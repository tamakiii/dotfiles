
install: standard docker

standard:
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
	  npm \
	  software-properties-common \
	  openjdk-8-jre

docker:
	sudo apt-get update
	sudo apt-get install \
		     apt-transport-https \
		     ca-certificates \
		     curl \
		     software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get install -y docker-ce

