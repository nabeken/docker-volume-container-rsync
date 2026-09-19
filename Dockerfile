FROM debian:13@sha256:9cc080028c43b27d2074d63a5f9caf7166d731494965616c1a6d2827a004585c
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
