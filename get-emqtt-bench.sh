#!/usr/bin/env bash

set -xeuo pipefail

VSN="${1:-0.5.3}"

. /etc/os-release
if [[ "${ID_LIKE:-}" =~ rhel|fedora ]]; then
    DIST='el'
    case ${ID} in
        amzn)
            VERSION_ID="7"
            ;;
        *)
            VERSION_ID="${VERSION_ID%%.*}"
            ;;
    esac
fi
SYSTEM="${ID}${VERSION_ID}"

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
cp -v /emqtt-bench/_build/emqtt_bench/bin/* /usr/local/bin/

# cleanup
rm -rf /emqtt-bench
