ARG BUILD_FROM=centos:7
FROM ${BUILD_FROM}

RUN yum install epel-release -y && yum update -y
RUN yum install -y autoconf \
                   bison-devel \
                   curl \
                   flex-devel \
                   jq \
                   libatomic \
                   libtool \
                   ncurses-devel \
                   python3 \
                   python3-pip \
                   systemd \
                   unixODBC-devel \
                   unzip \
                   vim \
                   wget \
                   which \
                   zip \
                   zlib-devel

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

RUN yum install -y centos-release-scl
RUN yum install -y devtoolset-8-gcc devtoolset-8-gcc-c++

ADD install-openssl11.sh /install-openssl11.sh
RUN /install-openssl11.sh

WORKDIR /

ENV GIT_VERSION=2.38.1 DEVELOPER_CFLAGS='-std=gnu99'
RUN curl -L -o /tmp/git.tar.gz "https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz" \
    && tar zxf /tmp/git.tar.gz -C /tmp \
    && cd "/tmp/git-${GIT_VERSION}/" \
    && make configure \
    && ./configure --prefix=/usr \
    && make all \
    && make install \
    && cd / \
    && rm -rf /tmp/git.tar.gz "/tmp/git-${GIT_VERSION}/" \
    && git --version

RUN curl -L -o /tmp/automake-1.14.tar.gz http://ftp.gnu.org/gnu/automake/automake-1.14.tar.gz \
    && tar -zxvf /tmp/automake-1.14.tar.gz -C /tmp \
    && cd /tmp/automake-1.14 \
    && ./bootstrap.sh \
    && ./configure \
    && make \
    && make install \
    && automake --version

COPY get-cmake.sh /get-cmake.sh
RUN env OPENSSL_ROOT_DIR=/usr/local/openssl /get-cmake.sh build

# We have to reinstall `glibc-common` after removing the override just
# for the `arm64` platform build of CentOS 7.  While just setting the
# locale works for `amd64`, even `en_US.UTF-8`, which is in the
# override for `arm64`, is not available...
RUN sed -i -e '/override_install_langs/d' /etc/yum.conf && \
    yum -q -y reinstall glibc-common

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
    rm -rf /var/tmp/*

ENV BASH_ENV=/opt/rh/devtoolset-8/enable \
    ENV=/opt/rh/devtoolset-8/enable \
    PROMPT_COMMAND=". /opt/rh/devtoolset-8/enable"

# Elixir complains if runs without UTF-8
# CentOS 7, exceptionally, has an `en_US.UTF-8` override as does not
# have `C.UTF-8`.
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

# merge the two dirs
ENV ACLOCAL_PATH=/usr/share/aclocal:/usr/local/share/aclocal

CMD [ "/bin/bash" ]
