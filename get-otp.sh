#!/bin/sh

set -eu

OTP_VERSION="$1"

# keep the file names compiled into beams short
ROOT='/'

cd "$ROOT"

name="OTP-${OTP_VERSION}"
download_url="https://github.com/emqx/otp/archive/${name}.zip"
echo "Downloading ${download_url}"
curl --silent --show-error -fkL ${download_url} -o "${name}.zip"

unzip -q "$name.zip"
rm -f "$name.zip"

mv "otp-$name" "otp-${OTP_VERSION}"
cd "otp-${OTP_VERSION}"

OTP_VERSION_IN_FILE="$(cat ./OTP_VERSION | tr -d '\n' | tr -d '\r')"
if [ "$OTP_VERSION_IN_FILE" != "$OTP_VERSION" ]; then
    echo "OTP_VERSION tag and file mismatch"
    echo "tag: $OTP_VERSION"
    echo "file: $OTP_VERSION_IN_FILE"
    exit 1
fi

if [ ! -f configure ]; then
    ./otp_build autoconf
fi

if [ -d /usr/local/openssl ]; then
    extra_config="--with-ssl=/usr/local/openssl"
else
    extra_config=""
fi
case "$(uname -m):${OTP_VERSION}" in
    aarch64:25*)
        # NOTE
        # Since OTP-25.0 JIT flavoured VM is compiled by default on ARM64, but
        # the resulting binary segfaults consistently. Disable JIT builds on
        # ARM64 as a workaround while investigating the root cause.
        extra_config="${extra_config} --disable-jit"
        ;;
    *)
        ;;
esac
./configure --disable-hipe ${extra_config}

make -j $(nproc)
make install

# cleanup
cd "$ROOT"
rm -rf "otp-${OTP_VERSION}"

# print out otp version to build logs
echo -n "OTP_VERSION="
erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().' -noshell

#########################
# Get rebar3
#########################

case "${OTP_VERSION}" in
    27*)
        REBAR3_VERSION="${REBAR3_VERSION:-3.20.0-emqx-3}"
        ;;
    26*)
        REBAR3_VERSION="${REBAR3_VERSION:-3.20.0-emqx-1}"
        ;;
    25*)
        REBAR3_VERSION="${REBAR3_VERSION:-3.19.0-emqx-9}"
        ;;
    24*)
        REBAR3_VERSION="${REBAR3_VERSION:-3.18.0-emqx-1}"
        ;;
    2*)
        REBAR3_VERSION="${REBAR3_VERSION:-3.14.3-emqx-4}"
        ;;
    *)
        echo "OTP_VERSION is invalid: ${OTP_VERSION}"
        exit 1
esac

cd /usr/local/bin
DOWNLOAD_URL='https://github.com/emqx/rebar3/releases/download'
curl --silent --show-error -fkL "${DOWNLOAD_URL}/${REBAR3_VERSION}/rebar3" -o ./rebar3
chmod +x ./rebar3

echo -n "REBAR3_VERSION="
# print out rebar3 version to build logs
./rebar3 --version
