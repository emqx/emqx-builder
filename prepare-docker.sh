#!/bin/sh

set -eu

mkdir -p $HOME/.docker
echo '{ "experimental": "enabled" }' | tee $HOME/.docker/config.json
echo '{ "experimental": true, "storage-driver": "overlay2", "max-concurrent-downloads": 50, "max-concurrent-uploads": 50, "graph": "/mnt/docker" }' | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker
docker version
docker buildx create --use --name mybuild
docker run --rm --privileged tonistiigi/binfmt --install all
