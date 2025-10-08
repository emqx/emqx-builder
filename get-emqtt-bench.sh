#!/usr/bin/env bash

set -xeuo pipefail

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

OTP_VERSION="$(erl -eval 'io:format("~s", [erlang:system_info(otp_release)]), halt().' -noshell)"

case "${OTP_VERSION}" in
    28*)
        VSN="${1:-0.5.5}"
        ;;
    27*)
        VSN="${1:-0.5.2}"
        ;;
    26*)
        VSN="${1:-0.5.0}"
        ;;
    25*)
        VSN="${1:-0.5.0}"
        ;;
    24*)
        VSN="${1:-0.4.17}"
        ;;
    *)
        echo "OTP_VERSION is invalid: ${OTP_VERSION}"
        exit 1
esac

git clone --depth=1 --branch="${VSN}" https://github.com/emqx/emqtt-bench.git /emqtt-bench
make REBAR=/usr/local/bin/rebar3 -C /emqtt-bench
cp -v /emqtt-bench/_build/emqtt_bench/bin/* /usr/local/bin/

# cleanup
rm -rf /emqtt-bench
