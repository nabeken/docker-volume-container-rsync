# docker-volume-container-rsync

A volume container using rsync.

## Usage

First, you can launch a volume container exposing a volume with rsync.

```sh
$ CID=$(docker run -d -p 10873:873 nabeken/docker-volume-container-rsync)
```

You can connect to rsync server inside a container like this:

```sh
$ rsync rsync://<docker>:10873/
volume          docker volume
```

To sync:

```sh
$ rsync -avP /path/to/dir rsync://<docker>:10873/volume/
```

Next, you can launch a container connected with the volume under `/docker`.

```sh
$ docker run -it --volumes-from $CID ubuntu /bin/sh
```

## Advanced

In default, rsync server accepts a connection only from `192.168.0.0/16` and `172.12.0.0/12` for security reasons.
You can override via an environment variable like this:

```sh
$ docker run -d -p 10873:873 -e ALLOW='10.0.0.0/8 x.x.x.x/y' nabeken/docker-volume-container-rsync
```

Also, rsync server exposes the volume under `/docker` in default.
You can override a path via an environment variable like this:

```sh
$ docker run -d -p 10873:873 -e VOLUME='/var/jenkins_home' -v /var/jenkins_home nabeken/docker-volume-container-rsync
```
