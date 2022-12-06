ARG BUILD_FROM=rockylinux:8
FROM ${BUILD_FROM}

RUN yum install epel-release -y && yum update -y
RUN yum install -y autoconf \
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
                   zip

RUN yum install -y \
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

WORKDIR /

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

RUN alternatives --set python /usr/bin/python3 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip3 2 && \
    alternatives --set pip /usr/bin/pip3

# cleanup
RUN yum clean packages \
 && rm -rf /tmp/* /var/tmp/*

# Elixir complains if runs without UTF-8
RUN yum clean packages && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

WORKDIR /
CMD [ "/bin/bash" ]
