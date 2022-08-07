FROM debian:11.4

RUN apt update && \
    apt install -y --no-install-recommends \
      make \
      vim \
      && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

