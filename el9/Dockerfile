ARG BUILD_FROM=rockylinux:9
FROM ${BUILD_FROM}

RUN dnf -y update && dnf -y groupinstall development
RUN dnf -y install \
    jq \
    libatomic \
    ncurses-devel \
    openssl-devel \
    perl-FindBin \
    python3-pip \
    procps-ng \
    systemd \
    vim \
    wget \
    which

RUN dnf -y install \
    krb5-workstation \
    krb5-devel \
    cyrus-sasl-devel \
    cyrus-sasl \
    cyrus-sasl-gssapi

# The following is not necessary for Kerberos authentication but makes testing
# https://github.com/kafka4beam/sasl_auth easier
RUN dnf -y install \
    krb5-server \
    expect

RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

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
