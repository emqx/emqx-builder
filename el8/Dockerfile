ARG BUILD_FROM=rockylinux:8
FROM ${BUILD_FROM}

RUN yum install epel-release -y && yum update -y
RUN yum install -y \
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
                   openssl-devel \
                   python3 \
                   python3-pip \
                   unixODBC \
                   unixODBC-devel \
                   unzip \
                   vim \
                   wget \
                   which \
                   zip

RUN yum groupinstall -y "Development Tools"

COPY get-openssl.sh /get-openssl.sh
RUN /get-openssl.sh

RUN yum install -y python3

## we do not want python2 anymore
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

WORKDIR /

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

# cleanup
RUN yum clean packages \
 && rm -rf /tmp/* /var/tmp/*

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]