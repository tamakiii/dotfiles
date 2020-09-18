FROM debian:10.5

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      make \
      zsh \
      vim \
      tmux \
      git \
      ssh \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
