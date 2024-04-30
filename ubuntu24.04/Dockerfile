ARG BUILD_FROM=public.ecr.aws/ubuntu/ubuntu:24.04
FROM ${BUILD_FROM}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    autoconf \
    automake \
    autotools-dev \
    bison \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    debhelper \
    expect \
    flex \
    git \
    inotify-tools \
    jq \
    krb5-admin-server \
    krb5-kdc \
    libffi-dev \
    libkrb5-3 \
    libkrb5-dev \
    libncurses5-dev \
    libsasl2-2 \
    libsasl2-dev \
    libsasl2-modules-gssapi-mit \
    libssl-dev \
    libtool \
    python3 \
    python3-pip \
    software-properties-common \
    unixodbc \
    unixodbc-dev \
    unzip \
    vim \
    wget \
    zip \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

RUN cmake --version

WORKDIR /

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]
