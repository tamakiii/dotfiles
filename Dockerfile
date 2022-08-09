FROM debian:11.4

RUN apt update && \
    apt install -y --no-install-recommends make

COPY . /root/.dotfiles

RUN make -C /root/.dotfiles install && \
    apt clean && \
    rm -rf /root/.dotfiles && \
    rm -rf /var/lib/apt/lists/*

