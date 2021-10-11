ARG BUILD_FROM=centos:7
FROM ${BUILD_FROM}

RUN yum install epel-release -y && yum update -y
RUN yum install -y wget zip which curl unzip vim ncurses-devel unixODBC-devel jq libatomic openssl-devel zlib-devel
RUN yum groupinstall -y "Development Tools"

RUN yum install -y centos-release-scl
RUN yum install -y devtoolset-8-gcc devtoolset-8-gcc-c++

COPY get-git.sh /get-git.sh
RUN /get-git.sh

WORKDIR /

RUN yum install -y bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel gcc gcc-c++ openssl-devel \
    && curl -L -o Python-3.6.7.tgz https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz \
    && tar xvf Python-3.6.7.tgz \
    && cd Python-3.6.7 \
    && echo "_socket socketmodule.c" >> Modules/Setup.dist \
    && echo "_ssl _ssl.c -DUSE_SSL -I/usr/local/ssl/include -I/usr/local/ssl/include/openssl -L/usr/local/ssl/lib -lssl -lcrypto" >> Modules/Setup.dist \
    && ./configure --prefix=/usr/local/python3.6.7 \
    && make \
    && make install \
    && rm -rf /usr/bin/python3 \
    && ln -s /usr/local/python3.6.7/bin/python3.6 /usr/bin/python3
RUN yum install -y python36-setuptools && easy_install-3.6 pip

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

WORKDIR /

ENV BASH_ENV=/opt/rh/devtoolset-8/enable \
    ENV=/opt/rh/devtoolset-8/enable \
    PROMPT_COMMAND=". /opt/rh/devtoolset-8/enable"

CMD [ "/bin/bash" ]
