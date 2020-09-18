FROM debian:10.5

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      make \
      zsh \
      vim \
      tmux \
      git \
      ssh \
      curl \
      ca-certificates \
      locales \
      less \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN localedef -f UTF-8 -i ja_JP ja_JP && \
    update-locale ja_JP.UTF-8

ENV LC_TYPE ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
