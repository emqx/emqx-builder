ARG BUILD_FROM=rockylinux/rockylinux:9.6
FROM ${BUILD_FROM}

# Disable mirrorlist, enable baseurl, and point to vault for Rocky Linux 9.6
RUN sed -i 's/^mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/rocky.repo && \
    sed -i 's/^#baseurl=/baseurl=/g' /etc/yum.repos.d/rocky.repo && \
    sed -i 's|dl.rockylinux.org/\$contentdir/\$releasever|dl.rockylinux.org/vault/rocky/9.6|g' /etc/yum.repos.d/rocky.repo

RUN dnf -y groupinstall development
# perl-IPC-Cmd is required to build TLS 3 (dependency of msquic)
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
    perl-IPC-Cmd \
    which

RUN ln -s /usr/bin/python3 /usr/bin/python

ADD el9/get-protoc.sh get-cmake.sh  /

WORKDIR /

RUN /get-protoc.sh && \
    /get-cmake.sh build && \
    wget ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-2.3.11.tar.gz && \
    tar xzf unixODBC-2.3.11.tar.gz && \
    cd unixODBC-2.3.11 && \
    ./configure && make && make install && \
    cd .. && \
    rm -rf unixODBC-2.3.11 && \
    rm -f unixODBC-2.3.11.tar.gz \
    dnf clean all && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install Rustup to a system-wide location
ENV RUSTUP_HOME=/usr/local/lib/rustup
ENV CARGO_HOME=/usr/local/cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none
ENV PATH="/usr/local/cargo/bin:${PATH}"

WORKDIR /
CMD [ "/bin/bash" ]
