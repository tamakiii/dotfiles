FROM debian:11.4

RUN apt update && \
    apt install -y --no-install-recommends make

COPY . /tmp/dotfiles

RUN make -C /tmp/dotfiles install && \
    apt clean && \
    rm -rf /tmp/dotfiles && \
    rm -rf /var/lib/apt/lists/*
