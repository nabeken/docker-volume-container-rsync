FROM debian:13@sha256:3615a749858a1cba49b408fb49c37093db813321355a9ab7c1f9f4836341e9db
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
