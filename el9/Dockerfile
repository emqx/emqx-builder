ARG BUILD_FROM=public.ecr.aws/docker/library/rockylinux:9
FROM ${BUILD_FROM}

RUN dnf -y update && dnf -y groupinstall development
RUN dnf -y install \
    cyrus-sasl \
    cyrus-sasl-devel \
    cyrus-sasl-gssapi \
    expect \
    jq \
    krb5-devel \
    krb5-server \
    krb5-workstation \
    libatomic \
    ncurses-devel \
    openssl-devel \
    perl-FindBin \
    procps-ng \
    python3-pip \
    systemd \
    vim \
    wget \
    which

RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /

COPY el9/openssl11.sh get-cmake.sh /

RUN /openssl11.sh && rm /openssl11.sh
RUN /get-cmake.sh build && rm /get-cmake.sh

RUN wget ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-2.3.11.tar.gz && \
    tar xzf unixODBC-2.3.11.tar.gz && \
    cd unixODBC-2.3.11 && \
    ./configure && make && make install && \
    cd .. && \
    rm -rf unixODBC-2.3.11 && \
    rm -f unixODBC-2.3.11.tar.gz

# cleanup
RUN dnf clean all && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]
