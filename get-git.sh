#!/usr/bin/env bash

set -euo pipefail

GIT_VERSION="${GIT_VERSION:-2.38.1}"

URL="https://github.com/git/git/archive/refs/tags/v${GIT_VERSION}.tar.gz"

## download and untar
cd /
curl --silent --show-error -fkL "$URL" -o "git.tar.gz"
tar -zxf git.tar.gz

## build
cd "/git-${GIT_VERSION}/"

make configure
./configure --prefix=/usr
make all
make install

## cleanup
cd /
rm -rf git.tar.gz "/git-${GIT_VERSION}/"
