#!/usr/bin/env bash

set -euo pipefail

AUTOMAKE_VERSION="${AUTOMAKE_VERSION:-1.14}"

PACKAGE="automake-$AUTOMAKE_VERSION"
ARCHIVE="$PACKAGE.tar.gz"
URL="http://ftp.gnu.org/gnu/automake/$ARCHIVE"
curl --silent --show-error -fkL -o "/tmp/$ARCHIVE" "$URL"
tar -zxvf "/tmp/$ARCHIVE" -C /tmp
cd "/tmp/$PACKAGE"
./bootstrap.sh
./configure
make
make install
automake --version

cd /
rm -rf "/tmp/$ARCHIVE" "/tmp/$PACKAGE"
