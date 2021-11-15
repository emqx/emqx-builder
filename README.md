# Docker images for EMQ X Builder

This rpo holds the Dockerfile and build scripts to build
docker images which are used to build EMQ X.

The main-4.4 branch is for EMQ X 4.4 series.

## OTP repo https://github.com/emqx/otp.git

EMQ X uses a forked Erlang/OTP with the tag scheme `<UPSTREAM_TAG>-N`
where `N` is the build number which includes bug fixes to Erlang/OTP srouce code.
For example: `OTP-23.3.4.9-2`

## Add new OTP versions to build

Add the new version to `RELEASE.md`

## Image tag scheme

```
ghcr.io/emqx/emqx-builder/4.4:23.3.4.9-2-centos7
```
