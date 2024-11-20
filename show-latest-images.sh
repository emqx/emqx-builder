#!/usr/bin/env bash

## This script prints out all the possible emqx-builder docker image tags built from the latest git tag

GREP='grep --color=never'
ALL_SYS="$($GREP -A28 'platforms=' .github/workflows/main.yaml | \
            $GREP -oE '{.*}' | \
            jq .os | \
            tr -d '"' | \
            sort -u)"

GIT_TAG="$(git describe --abbrev=0 --tags)"
OTP_ELIXIR_VERSIONS="$($GREP -oE "OTP-.*,Elixir.*" ./RELEASE.md)"
for line in $OTP_ELIXIR_VERSIONS; do
    otp="$(echo "$line" | sed -n 's/.*OTP-\([^,]*\),.*/\1/p')"
    elixir="$(echo "$line" | sed -n 's/.*Elixir-\([^,]*\)/\1/p')"
    echo ">>>>>>>>>>>>>>> $line"
    for sys in $ALL_SYS; do
        echo "ghcr.io/emqx/emqx-builder/${GIT_TAG}:${elixir}-${otp}-${sys}"
    done
done
