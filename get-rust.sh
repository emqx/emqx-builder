#!/bin/sh

set -eu

RUST_VERSION="${1:-1.88.0}"

if [ -n "${RUST_VERSION}" ]; then
  rustup toolchain install ${RUST_VERSION}
  rustup default ${RUST_VERSION}
fi
