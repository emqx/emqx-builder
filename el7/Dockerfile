ARG BUILD_FROM=centos:7
FROM ${BUILD_FROM}

RUN yum install epel-release -y && yum update -y
RUN yum install -y wget zip which curl unzip vim ncurses-devel unixODBC-devel jq libatomic openssl-devel zlib-devel openssl11
RUN yum groupinstall -y "Development Tools"

RUN yum install -y centos-release-scl
RUN yum install -y devtoolset-8-gcc devtoolset-8-gcc-c++

COPY get-git.sh /get-git.sh
RUN /get-git.sh

WORKDIR /

# install openssl 1.1.1n to /usr/local/openssl
# the openssl11 yum install is still needed
# /user/local/openssl is to confgure/build Erlang/OTP
# openssl11 is for runtime
# there is no easy way to use one version for both
COPY get-openssl.sh /get-openssl.sh
RUN /get-openssl.sh

RUN yum install -y python3
## we do not want python2 anymore
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip
## yum needs python2
RUN sed 's/python/python2/g' -i /usr/bin/yum

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

# cleanup
RUN yum clean packages \
 && rm -rf /tmp/* /var/tmp/*

ENV BASH_ENV=/opt/rh/devtoolset-8/enable \
    ENV=/opt/rh/devtoolset-8/enable \
    PROMPT_COMMAND=". /opt/rh/devtoolset-8/enable"

CMD [ "/bin/bash" ]
