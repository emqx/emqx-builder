ARG BUILD_FROM=debian:11
FROM ${BUILD_FROM}

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    bison \
    build-essential \
    curl \
    debhelper \
    flex \
    g++ \
    gcc \
    git \
    jq \
    libffi-dev \
    libkrb5 \
    libkrb5-dev \
    libncurses5-dev \
    libsasl2 \
    libsasl2-dev \
    libsasl2-modules-gssapi-mit \
    libssl-dev \
    libtool \
    make \
    procps \
    python3 \
    python3-pip \
    unixodbc \
    unixodbc-dev \
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

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

# cleanup
RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]
