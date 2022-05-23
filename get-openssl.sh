#!/usr/bin/env bash

set -euo pipefail

VSN="${1:-1.1.1n}"
NAME="openssl-$VSN"
FILE="$NAME.tar.gz"
curl -o "$FILE" -f -L "https://www.openssl.org/source/$FILE"

tar zxf "$FILE"
pushd "$NAME"
# NOTE: this prefix path is used in get-otp.sh
./config --prefix=/usr/local/openssl
make install_sw
popd
rm -rf "$NAME/"
