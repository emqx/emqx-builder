ARG BUILD_FROM=public.ecr.aws/debian/debian:12
FROM ${BUILD_FROM}

# Avoid getting asked questions during installation (tzdata)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    bison \
    build-essential \
    cmake \
    curl \
    debhelper \
    expect \
    flex \
    git \
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
    procps \
    python3 \
    python3-pip \
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

CMD [ "/bin/bash" ]
