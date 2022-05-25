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
                   openssl11 \
                   openssl11-devel \
                   systemd \
                   unixODBC-devel \
                   unzip \
                   vim \
                   wget \
                   which \
                   zip \
                   zlib-devel

RUN yum groupinstall -y "Development Tools"

RUN yum install -y centos-release-scl
RUN yum install -y devtoolset-8-gcc devtoolset-8-gcc-c++

COPY get-git.sh /get-git.sh
RUN /get-git.sh

WORKDIR /

RUN mkdir -p /usr/local/openssl/include; \
    ln -s /usr/include/openssl11/openssl /usr/local/openssl/include/openssl; \
    ln -s /usr/lib64/openssl11 /usr/local/openssl/lib
ENV OPENSSL_ROOT_DIR=/usr/local/openssl
RUN curl -L -o /tmp/automake-1.14.tar.gz http://ftp.gnu.org/gnu/automake/automake-1.14.tar.gz \
    && tar -zxvf /tmp/automake-1.14.tar.gz -C /tmp \
    && cd /tmp/automake-1.14 \
    && ./bootstrap.sh \
    && ./configure \
    && make \
    && make install \
    && automake --version

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

# We have to reinstall `glibc-common` after removing the override just
# for the `arm64` platform build of CentOS 7.  While just setting the
# locale works for `amd64`, even `en_US.UTF-8`, which is in the
# override for `arm64`, is not available...
RUN sed -i -e '/override_install_langs/d' /etc/yum.conf && \
    yum -q -y reinstall glibc-common

RUN yum install -y python3
## we do not want python2 anymore
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

## yum needs python2
RUN sed 's/python/python2/g' -i /usr/bin/yum

# cleanup
RUN yum clean packages \
    && rm -rf /tmp/* /var/tmp/*

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
