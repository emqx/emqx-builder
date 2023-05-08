ARG BUILD_FROM=amazonlinux:2
FROM ${BUILD_FROM}

RUN yum update -y && yum groupinstall -y "Development Tools" && yum install -y \
    curl \
    git \
    expect \
    jq \
    ncurses-devel \
    openssl11 \
    openssl11-devel \
    python3 \
    python3-pip \
    systemd \
    unixODBC \
    unixODBC-devel \
    vim \
    wget \
    which \
    krb5-workstation \
    krb5-server \
    cyrus-sasl-devel \
    cyrus-sasl \
    cyrus-sasl-gssapi && \
    yum clean packages

ADD get-cmake.sh get-automake.sh  /

WORKDIR /

RUN yum remove -y automake && \
    /get-automake.sh && \
    /get-cmake.sh build

RUN alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
    alternatives --install /usr/bin/python python /usr/bin/python3 2 && \
    alternatives --set python /usr/bin/python3 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip2 1 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip3 2 && \
    alternatives --set pip /usr/bin/pip3 && \
    sed 's/python/python2/g' -i /usr/bin/yum

# cleanup
RUN yum clean packages && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm /get-cmake.sh /get-automake.sh

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD [ "/bin/bash" ]
