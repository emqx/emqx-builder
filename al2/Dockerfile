ARG BUILD_FROM=amazonlinux:2
FROM ${BUILD_FROM}

RUN yum update -y && yum install -y \
    autoconf \
    automake \
    bison \
    curl \
    flex \
    git \
    jq \
    libatomic \
    libtool \
    ncurses-devel \
    openssl \
    openssl-devel \
    python3 \
    python3-pip \
    systemd \
    unixODBC \
    unixODBC-devel \
    unzip \
    vim \
    wget \
    which \
    zip \
    krb5-workstation \
    cyrus-sasl-devel \
    cyrus-sasl \
    cyrus-sasl-gssapi

# The following is not necessary for Kerberos authentication but makes testing
# https://github.com/kafka4beam/sasl_auth easier
RUN yum install -y \
    krb5-server \
    expect

RUN yum groupinstall -y "Development Tools"

# cleanup
RUN yum clean packages && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

WORKDIR /

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

# make python3 the default as the last step to not break yum
RUN alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
    alternatives --install /usr/bin/python python /usr/bin/python3 2

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD [ "/bin/bash" ]
