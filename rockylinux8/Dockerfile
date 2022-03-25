ARG BUILD_FROM=rockylinux:8
FROM ${BUILD_FROM}

RUN yum install epel-release -y && yum update -y
RUN yum install -y wget \
                   git \
                   zip \
                   which \
                   curl \
                   unzip \
                   vim \
                   ncurses-devel \
                   openssl-devel \
                   unixODBC \
                   unixODBC-devel \
                   jq \
                   libatomic \
                   python3 \
                   python3-pip

RUN yum groupinstall -y "Development Tools"

WORKDIR /

RUN yum install -y openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel gcc gcc-c++  openssl-devel \
    && curl -L -o Python-3.6.7.tgz https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz \
    && tar xvf Python-3.6.7.tgz \
    && cd Python-3.6.7 \
    && echo "_socket socketmodule.c" >> Modules/Setup.dist \
    && echo "_ssl _ssl.c -DUSE_SSL -I/usr/local/ssl/include -I/usr/local/ssl/include/openssl -L/usr/local/ssl/lib -lssl -lcrypto" >> Modules/Setup.dist \
    && ./configure --prefix=/usr/local/python3.6.7 \
    && make \
    && make install \
    && rm -rf /usr/bin/python3 \
    && ln -s /usr/local/python3.6.7/bin/python3.6 /usr/bin/python3 \
    && echo "alias python=/usr/bin/python3" >> ~/.bashrc
RUN yum install -y python3-pip && ln -s /usr/bin/pip3 /usr/bin/pip

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

# cleanup
RUN yum clean packages \
 && rm -rf /tmp/* /var/tmp/*

WORKDIR /
CMD [ "/bin/bash" ]
