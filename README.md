# Docker images for building EMQX v5 or later packages

This repo holds the Dockerfile and build scripts to build
docker images which are used to build EMQX.

The `main-4.4` branch is for EMQX 4.4 series.
The `main` branch is for EMQX 5.x series.

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

Notice that we do **not** track the _patch_ version of EMQX in our
image scheme: we have one base image for each minor release that can
be shared on a non one-to-one basis with several EMQX patch releases.

For example: EMQX `5.0.0` and `5.0.3` may share the same
`emqx-builder/5.0-2` image.
