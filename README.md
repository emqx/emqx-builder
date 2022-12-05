NOTE: Must sync Dockerfile chages from main-4.4 branch!

# Docker images for EMQX Builder

This repo holds the Dockerfile and build scripts to build
docker images which are used to build EMQX.

The `main-4.4` branch is for EMQX 4.4 series.
The `main` branch is for EMQX 5.0 series.

## OTP repo https://github.com/emqx/otp.git

EMQX uses a forked Erlang/OTP with the tag scheme `<UPSTREAM_TAG>-N`
where `N` is the build number which includes bug fixes to Erlang/OTP source code.
For example: `OTP-24.1.5-1`

## Add new OTP versions to build

When we need to support a new OTP version for a bugfix release,
we should add a new OTP tag to the list in RELEASE.md

for example, after `5.0.0-otp24.1.5-1` is released, in case there is a bug
found in OTP which requires OTP `24.2-1`, we should add `+ OTP-24.2-1` to the list.

This list should be append-only in case we want to rebuild an old EMQX tag,
we can still find an up-to-date docker image for it.

## Image tag scheme

```
ghcr.io/emqx/emqx-builder/<BUILDER_GIT_TAG>:24.1.5-1-ubuntu20.04
```

Where `BUILDER_GIT_TAG` is of scheme `4.4-1` for images to build EMQX 4.4
and `5.0-1`, `5.0-2` for images to build EMQX 5.0

Notice that we do **not** track the _patch_ version of EMQX in our
image scheme: we have one base image for each minor release that can
be shared on a non one-to-one basis with several EMQX patch releases.

For example: EMQX `5.0.0` and `5.0.3` may share the same
`emqx-builder/5.0-2` image.
