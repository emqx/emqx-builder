ARG BUILD_FROM=ubuntu:22.04
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
    flex \
    g++ \
    gcc \
    git \
    inotify-tools \
    jq \
    libffi-dev \
    libkrb5-3 \
    libkrb5-dev \
    libncurses5-dev \
    libsasl2-2 \
    libsasl2-dev \
    libsasl2-modules-gssapi-mit \
    libssl-dev \
    libtool \
    make \
    python3 \
    python3-pip \
    software-properties-common \
    unzip \
    vim \
    wget \
    zip \
    zlib1g-dev

# The following is not necessary for Kerberos authentication but makes testing
# https://github.com/kafka4beam/sasl_auth easier
RUN apt-get install -y \
    krb5-kdc \
    krb5-admin-server \
    expect

RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

RUN cmake --version

RUN apt-get update &&  apt-get install -y unixodbc unixodbc-dev

WORKDIR /


# cleanup
RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]
