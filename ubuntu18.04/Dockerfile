ARG BUILD_FROM=public.ecr.aws/ubuntu/ubuntu:18.04
FROM ${BUILD_FROM}

# Avoid getting asked questions during installation (tzdata)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y \
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
      g++-11 \
      gcc-11 \
      git \
      jq \
      krb5-admin-server \
      krb5-kdc \
      libbz2-dev \
      libcurl4-openssl-dev \
      libffi-dev \
      libgdbm-dev \
      libkrb5-3 \
      libkrb5-dev \
      libncurses5-dev \
      libnss3-dev \
      libreadline-dev \
      libsasl2-2 \
      libsasl2-dev \
      libsasl2-modules-gssapi-mit \
      libsqlite3-dev \
      libssl-dev \
      libtool \
      make \
      manpages-dev \
      unixodbc \
      unixodbc-dev \
      unzip \
      vim \
      wget \
      zip \
      zlib1g-dev && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/gcov gcov /usr/bin/gcov-7 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 11 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /

ARG PYTHON_VERSION=3.9.20
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

# We need git >= 2.18 otherwise actions/checkout@v3 in github
# workflows will use REST API to download source code archive without
# .git directory instead of normal git clone. And if release is
# configured to take it's version from git tag, rebar3 will not be
# able to resolve the version correctly and will fallback to 0.0.0,
# like it happened with emqtt-bench.
# The error from actions/checkout@v3 is as follows:
# > The repository will be downloaded using the GitHub REST API
# > To create a local Git repository instead, add Git 2.18 or higher to the PATH
RUN /get-git.sh && git --version && rm /get-git.sh

RUN /get-cmake.sh build && rm /get-cmake.sh

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install Rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none
ENV PATH="/root/.cargo/bin:${PATH}"

CMD [ "/bin/bash" ]
