FROM debian:trixie-20260505@sha256:0bea168ca3987374732de970508d6dd701d36ee68781b18aadaddca04a95d392
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
