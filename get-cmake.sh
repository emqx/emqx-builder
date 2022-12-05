#!/bin/sh

set -eu

VSN=${2:-"3.19.2"}
ARCH=$(arch)

if [ -d '/usr/local/openssl' ]; then
    export OPENSSL_ROOT_DIR='/usr/local/openssl'
    echo "OPENSSL_ROOT_DIR=$OPENSSL_ROOT_DIR"
fi
if [ "${1:-}" = 'build' ]; then
    curl --silent --show-error -kfL -o cmake.tar.gz "https://github.com/Kitware/CMake/releases/download/v${VSN}/cmake-${VSN}.tar.gz"
    tar -zxf cmake.tar.gz
    rm -f cmake.tar.gz
    cd "cmake-${VSN}/"

    ./bootstrap --parallel=$(nproc)
    make -j$(nproc)
    make install
    cd ..
    rm -rf "cmake-${VSN}/"
    cmake --version
else
    curl --silent --show-error -kfL -o cmake.tar.gz "https://github.com/Kitware/CMake/releases/download/v${VSN}/cmake-${VSN}-Linux-$ARCH.tar.gz"
    tar -zxf cmake.tar.gz
    rm -f cmake.tar.gz
    mv "cmake-${VSN}-Linux-$ARCH/" /cmake
fi
