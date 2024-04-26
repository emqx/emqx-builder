#!/usr/bin/env bash

set -euo pipefail

ARCH=$(arch)
if [ "${ARCH}" != "x86_64" ]; then
    echo "Unsupported architecture: ${ARCH}"
    exit 0
fi

BASE_URL="https://github.com/apple/foundationdb/releases/download/${FDB_VERSION}"
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
    SYSTEM="${DIST}${VERSION_ID}"
    case ${SYSTEM} in
        el7)
            wget "${BASE_URL}/foundationdb-clients-${FDB_VERSION}-1.${SYSTEM}.${ARCH}.rpm" -O ./foundationdb-clients.rpm
            rpm -i ./foundationdb-clients.rpm
            rm ./foundationdb-clients.rpm
            ;;
        *)
            echo "Unsupported system: ${SYSTEM}"
            exit 0
            ;;
    esac
elif [[ "${ID:-}" =~ debian|ubuntu ]]; then
    ARCH=$(dpkg --print-architecture)
    SYSTEM="${ID}${VERSION_ID}"
    case ${SYSTEM} in
        debian11 | debian12 | ubuntu20.04 | ubuntu22.04)
            wget "${BASE_URL}/foundationdb-clients_${FDB_VERSION}-1_${ARCH}.deb" -O foundationdb-clients.deb
            dpkg -i foundationdb-clients.deb
            rm foundationdb-clients.deb
            ;;
        *)
            echo "Unsupported system: ${SYSTEM}"
            exit 0
            ;;
    esac
fi
