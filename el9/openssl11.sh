#!/bin/sh

set -eux

dnf install -y make gcc perl-core pcre-devel wget zlib-devel
wget https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1w/openssl-1.1.1w.tar.gz
echo 'cf3098950cb4d853ad95c0841f1f9c6d3dc102dccfcacd521d93925208b76ac8 *openssl-1.1.1w.tar.gz' | sha256sum -c
tar xfz openssl-1.1.1w.tar.gz
cd openssl-1.1.1w
mkdir /usr/local/openssl-1.1.1
./config --prefix=/usr/local/openssl-1.1.1 --openssldir=/usr/local/openssl-1.1.1 --libdir=lib zlib-dynamic
make -j$(nproc)
make install
ln -s /usr/local/openssl-1.1.1/lib/libssl.so /usr/lib64/libssl.so.1.1
ln -s /usr/local/openssl-1.1.1/lib/libcrypto.so /usr/lib64/libcrypto.so.1.1

chmod -R 755 /usr/lib64/libssl.so.1.1
chmod -R 755 /usr/lib64/libcrypto.so.1.1

ldconfig
