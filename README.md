# docker-volume-container-rsync

`docker-volume-container-rsync` is to provide RSYNC access to a mounted volume. You can synchronize your local file over RSYNC into a container volume very fast.

## News (as of Dec 2, 2022)

I've moved to GHCR (Github Container Registery) and a new repository provides multi-arch images for Linux/amd64 and Linux/arm64.

I'll not remove old images but please migrate to the new location.

## Usage

First, you can launch a volume container exposing a volume with rsync.

```sh
CID=$(docker run -d -p 10873:873 ghcr.io/nabeken/docker-volume-container-rsync:latest)
```

You can connect to rsync server inside a container like this:

```sh
rsync rsync://<docker>:10873/
volume          docker volume
```

To sync:

```sh
rsync -avP /path/to/dir rsync://<docker>:10873/volume/
```

Next, you can launch a container connected with the volume under `/docker`.

```sh
docker run -it --volumes-from $CID ubuntu /bin/sh
```

## Advanced

In default, rsync server accepts a connection only from `192.168.0.0/16` and `172.16.0.0/12` for security reasons.
You can override via an environment variable like this:

```sh
docker run -d -p 10873:873 -e ALLOW='10.0.0.0/8 x.x.x.x/y' ghcr.io/nabeken/docker-volume-container-rsync:latest
```

## Using with different directory

Let's say you want to use `/data` rather than `/docker`.

First, you must launch a volume container exposing `/data` directory:

```sh
CID=$(docker run --volume /data -d -e VOLUME=/data -p 10873:873 ghcr.io/nabeken/docker-volume-container-rsync:latest)
```

Finally, you can mount the volumes from the container:

```sh
docker run -it --volumes-from $CID ubuntu /bin/sh
```
