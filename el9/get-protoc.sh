#!/usr/bin/env bash

set -euo pipefail

cd /tmp

PB_REL="https://github.com/protocolbuffers/protobuf/releases"
VSN="33.1"

case $(uname -m) in
  x86_64)
    ARCH="x86_64"
    ;;
  *)
    ARCH="aarch_64"
    ;;
esac

curl -LO "$PB_REL/download/v$VSN/protoc-$VSN-linux-$ARCH.zip"
unzip "protoc-$VSN-linux-$ARCH.zip" -d /usr/local/bin
