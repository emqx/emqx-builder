#!/bin/sh

set -eu

ELIXIR_VERSION="$1"

# keep the file names compiled into beams short
ROOT='/'

cd "$ROOT"

curl --silent --show-error -fkL "https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.zip" -o "${ELIXIR_VERSION}.zip"

unzip -q "${ELIXIR_VERSION}.zip"
rm -f "${ELIXIR_VERSION}.zip"

cd "elixir-${ELIXIR_VERSION}"

ELIXIR_VERSION_IN_FILE="$(cat ./VERSION | tr -d '\n\r')"
if [ "$ELIXIR_VERSION_IN_FILE" != "$ELIXIR_VERSION" ]; then
    echo "ELIXIR_VERSION tag and file mismatch"
    echo "tag: $ELIXIR_VERSION"
    echo "file: $ELIXIR_VERSION_IN_FILE"
    exit 1
fi

# Elixir will complain if compile not using utf-8

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

make -j $(nproc)
make install

# cleanup
cd "$ROOT"
rm -rf "elixir-${ELIXIR_VERSION}"

# print out elixir version to build logs
echo -n "ELIXIR_VERSION="
elixir -e "System.version() |> IO.puts()"
