#!/bin/sh

set -eu

VSN=${2:-"3.19.2"}

if [ "$1" = 'build' ]; then
    curl --silent --show-error -kfL -o cmake.tar.gz "https://github.com/Kitware/CMake/releases/download/v${VSN}/cmake-${VSN}.tar.gz"
    tar -zxf cmake.tar.gz
    rm -f cmake.tar.gz
    cd "cmake-${VSN}/"

    ./bootstrap --parallel=8
    make -j8
    make install
    cd ..
    rm -rf "cmake-${VSN}/"
    cmake --version
else
    curl --silent --show-error -kfL -o cmake.tar.gz "https://github.com/Kitware/CMake/releases/download/v${VSN}/cmake-${VSN}-Linux-x86_64.tar.gz"
    tar -zxf cmake.tar.gz
    rm -f cmake.tar.gz
    mv "cmake-${VSN}-Linux-x86_64/" /cmake
fi
