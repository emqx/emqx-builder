#!/usr/bin/env bash

## a help script to test arm builds on x86

set -euo pipefail

ARCH="$1"
BUILDER="$2"
docker run --rm --privileged tonistiigi/binfmt:latest --install "${ARCH}"
docker run -it --rm \
        -v "$(pwd)":/x\
        --workdir /x\
        --platform="linux/$ARCH" \
        "$BUILDER" \
        bash
