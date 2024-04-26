#!/usr/bin/env bash

set -xeuo pipefail

LUX_REF="${LUX_REF:-lux-2.9.1}"

mkdir -p /tools
git clone --depth=1 --branch=${LUX_REF} https://github.com/hawk/lux /tools/lux
cd /tools/lux
autoconf
./configure
make
make install
cd /tools
rm -rf lux
