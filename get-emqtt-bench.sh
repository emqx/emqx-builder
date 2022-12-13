#!/usr/bin/env bash

set -xeuo pipefail

VSN="$1"

if grep -q -i 'rhel' /etc/os-release; then
    DIST='el'
    VERSION_ID="$(rpm --eval '%{rhel}')"
else
    DIST="$(sed -n '/^ID=/p' /etc/os-release | sed -r 's/ID=(.*)/\1/g' | sed 's/"//g')"
    VERSION_ID="$(sed -n '/^VERSION_ID=/p' /etc/os-release | sed -r 's/VERSION_ID=(.*)/\1/g' | sed 's/"//g')"
fi
SYSTEM="$(echo "${DIST}${VERSION_ID}" | sed -r 's/([a-zA-Z]*)-.*/\1/g')"

# no quic on raspbian9 and centos7
case "$SYSTEM" in
    *raspbian9*)
        export BUILD_WITHOUT_QUIC=1
        ;;
    *el7*)
        export BUILD_WITHOUT_QUIC=1
        ;;
    *)
        true
        ;;
esac

git clone --depth=1 --branch="${VSN}" https://github.com/emqx/emqtt-bench.git /emqtt-bench
make REBAR=/usr/local/bin/rebar3 -C /emqtt-bench
cp -v /emqtt-bench/emqtt_bench /emqtt-bench/*.so /usr/local/bin/

# cleanup
rm -rf /emqtt-bench
