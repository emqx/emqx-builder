#!/bin/sh

## only intended for centos7

set -eux

if [ "$(uname -m)" = 'aarch64' ]; then
    ## hopeless for arm
    yum install -y openssl openssl-devel
else
    ## Default openssl-devel package installs OpenSSL 1.0.x,
    ## but we want 1.1.1 (from openssl11)
    ## Otherwise Erlang's crypto lib may link with old version libcrypto
    yum install -y openssl11 openssl11-devel
    mkdir -p /usr/local/openssl/include
    ln -s /usr/include/openssl11/openssl /usr/local/openssl/include/openssl
    ln -s /usr/lib64/openssl11 /usr/local/openssl/lib
    ln -s /usr/include/openssl11/openssl /usr/include/openssl
fi
