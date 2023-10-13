# Docker images for building EMQX v5 or later packages

This repo holds the Dockerfile and build scripts to build
docker images which are used to build EMQX.

The docker images are also pulled by a few other Erlang repos in the CI builds.

https://github.com/emqx/erlang-rocksdb
https://github.com/emqx/quic
https://github.com/emqx/emqtt

## OTP repo https://github.com/emqx/otp.git

EMQX uses a forked Erlang/OTP with the tag scheme `<UPSTREAM_TAG>-N`
where `N` is the build number which includes bug fixes to Erlang/OTP source code.
For example: `OTP-24.1.5-1`

## Image tag scheme

```
ghcr.io/emqx/emqx-builder/<BUILDER_GIT_TAG>:1.13.1-24.1.5-1-ubuntu20.04
```

Where `BUILDER_GIT_TAG` is of scheme `4.4-1` for images to build EMQX
4.4.X and `5.0-1`, `5.0-2` for images to build EMQX 5.0.X.  `1.13.1` and
`24.1.5-1` are the Elixir and OTP version, respectively.

Note that starting from 5.2, we no longer track EMQX versions in the image tag scheme.
i.e. `emqx-builder:5.2` does not mean it's only intended to build EMQX 5.2.
