#!/usr/bin/env bash

set -xeuo pipefail

LUX_REF="${1:-lux-3.0}"

mkdir -p /tools
git clone --depth=1 --branch=${LUX_REF} https://github.com/hawk/lux /tools/lux
cd /tools/lux
autoconf
./configure
make
make install
cd /tools
rm -rf lux
