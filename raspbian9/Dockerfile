FROM balenalib/rpi-raspbian:stretch

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    bison \
    cmake \
    curl \
    flex \
    g++ \
    gcc \
    jq  \
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
    unixodbc \
    unixodbc-dev \
    unzip \
    wget \
    zlib1g-dev

# The following is not necessary for Kerberos authentication but makes testing
# https://github.com/kafka4beam/sasl_auth easier
RUN apt-get install -y \
    krb5-kdc \
    krb5-admin-server \
    expect

RUN cmake --version

RUN apt-get update && apt-get install -y \
    ssh \
    wget \
    git \
    zip \
    build-essential \
    debhelper \
    curl \
    unzip \
    debhelper \
    vim

WORKDIR /

RUN apt-get install -y gcc make zlib1g-dev libffi-dev libssl-dev \
    && wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
    && tar xvf Python-3.7.4.tgz \
    && cd Python-3.7.4 \
    && echo "_socket socketmodule.c" >> Modules/Setup.dist \
    && echo "_ssl _ssl.c -DUSE_SSL -I/usr/local/ssl/include -I/usr/local/ssl/include/openssl -L/usr/local/ssl/lib -lssl -lcrypto" >> Modules/Setup.dist \
    && ./configure --prefix=/usr/local/python3.7.4 \
    && make \
    && make install \
    && rm -rf /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/local/python3.7.4/bin/python3.7 /usr/bin/python3 \
    && ln -s /usr/local/python3.7.4/bin/python3.7 /usr/bin/python
RUN curl -k -L -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
    && python /tmp/get-pip.py \
    && python3 /tmp/get-pip.py
ENV PATH=/usr/local/python3.7.4/bin:$PATH

# cleanup
RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Rustup to a system-wide location
ENV RUSTUP_HOME=/usr/local/lib/rustup
ENV CARGO_HOME=/usr/local/cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none
ENV PATH="/usr/local/cargo/bin:${PATH}"

WORKDIR /
CMD [ "/bin/bash" ]
