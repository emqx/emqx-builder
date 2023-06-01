#!/usr/bin/env bash

## This script prints out all the possible emqx-builder docker image tags built from the latest git tag

GREP='grep --color=never'
ALL_SYS="$($GREP -A20 'platform:' .github/workflows/main.yaml | \
            $GREP -E '\-\s?\[.*\]$' | \
            tr -d '\- []"' | \
            sed -e '/^#.*/d' | \
            cut -d',' -f1 | \
            sort -u)"

GIT_TAG="$(git describe --abbrev=0 --tags)"
OTP_VERSIONS="$($GREP -E "^\+\sOTP-.*" ./RELEASE.md | sed 's/\+\sOTP-//g')"
ELIXIR_VERSIONS="$($GREP -E "^\+\sElixir-.*" ./RELEASE.md | sed 's/\+\sElixir-//g')"
for elixir in $ELIXIR_VERSIONS; do
    for otp in $OTP_VERSIONS; do
        for sys in $ALL_SYS; do
            echo "ghcr.io/emqx/emqx-builder/${GIT_TAG}:${elixir}-${otp}-${sys}"
        done
    done
done
