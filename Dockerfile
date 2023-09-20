FROM debian:12@sha256:009f9947d64706e7bc84e44a1541d297b195ac3cb8e548a889218a5b2cee0211
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
