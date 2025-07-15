ARG BUILD_FROM=public.ecr.aws/debian/debian:10
FROM ${BUILD_FROM}

# Avoid getting asked questions during installation (tzdata)
ENV DEBIAN_FRONTEND=noninteractive

# Update sources.list to use archive repositories for Debian 10 (Buster)
RUN echo "deb http://archive.debian.org/debian buster main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y ca-certificates

# Use https endpoints
RUN echo "deb https://archive.debian.org/debian buster main contrib non-free" > /etc/apt/sources.list && \
    echo "deb https://archive.debian.org/debian buster-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb https://archive.debian.org/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    bison \
    build-essential \
    curl \
    debhelper \
    expect \
    flex \
    g++ \
    gcc \
    git \
    jq \
    krb5-admin-server \
    krb5-kdc \
    libcurl4-openssl-dev \
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
    make \
    procps \
    unixodbc \
    unixodbc-dev \
    unzip \
    vim \
    wget \
    zip \
    zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ARG PYTHON_VERSION=3.9.2
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && echo "_socket socketmodule.c" >> Modules/Setup.dist \
    && echo "_ssl _ssl.c -DUSE_SSL -I/usr/local/ssl/include -I/usr/local/ssl/include/openssl -L/usr/local/ssl/lib -lssl -lcrypto" >> Modules/Setup.dist \
    && ./configure --prefix=/usr/local/python${PYTHON_VERSION} \
    && make \
    && make install \
    && rm -rf /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/local/python${PYTHON_VERSION}/bin/python${PYTHON_VERSION%.*} /usr/bin/python3 \
    && ln -s /usr/local/python${PYTHON_VERSION}/bin/python${PYTHON_VERSION%.*} /usr/bin/python

RUN curl -k -L -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
    && python /tmp/get-pip.py \
    && python3 /tmp/get-pip.py

ENV PATH=/usr/local/python${PYTHON_VERSION}/bin:$PATH

ADD get-git.sh get-cmake.sh /

RUN /get-git.sh && git --version && rm /get-git.sh

RUN /get-cmake.sh build && rm /get-cmake.sh

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]
