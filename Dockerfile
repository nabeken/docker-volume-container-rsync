FROM debian:12@sha256:6001f38763856a0181c479eb4844467ea3dcb843335e0d8404e6b366a271c9ae
MAINTAINER TANABE Ken-ichi <nabeken@tknetworks.org>

SHELL ["/bin/bash" , "-c"]

RUN set -euxo pipefail; \
  apt-get update; \
  apt-get upgrade -y; \
  apt-get install -y --no-install-recommends rsync; \
  rm -rf /var/lib/apt/lists/*

EXPOSE 873
VOLUME /docker
ADD ./run /usr/local/bin/run

ENTRYPOINT ["/usr/local/bin/run"]
