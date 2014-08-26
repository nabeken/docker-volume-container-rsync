FROM ubuntu
MAINTAINER TANABE Ken-ichi <nabeken@tknetworks.org>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    rsync

EXPOSE 873
VOLUME /docker
ADD ./run /usr/local/bin/run

ENTRYPOINT ["/usr/local/bin/run"]
