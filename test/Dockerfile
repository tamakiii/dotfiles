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

RUN locale-gen && \
    sed -i 's/^# ja_JP.UTF-8 UTF-8$/ja_JP.UTF-8 UTF-8/g' /etc/locale.gen && \
    update-locale ja_JP.UTF-8

# ENV LANG ja_JP.UTF-8
# ENV LANGUAGE ja_JP:en
# ENV LC_ALL ja_JP.UTF-8
