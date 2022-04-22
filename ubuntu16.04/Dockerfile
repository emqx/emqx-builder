ARG BUILD_FROM=ubuntu:16.04
FROM ${BUILD_FROM}

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    autoconf \
    automake \
    autotools-dev \
    bison \
    build-essential \
    ca-certificates \
    curl \
    debhelper \
    flex \
    g++ \
    gcc \
    jq \
    libffi-dev \
    libncurses5-dev \
    libssl-dev \
    make \
    software-properties-common \
    unzip \
    vim \
    wget \
    zip \
    zlib1g-dev

RUN apt-get update &&  apt-get install -y unixodbc unixodbc-dev

WORKDIR /

RUN apt-get update && apt-get install -y libcurl4-openssl-dev \
    && wget https://github.com/git/git/archive/v2.17.1.tar.gz \
    && tar xzvf v2.17.1.tar.gz \
    && cd git-2.17.1/ \
    && make configure \
    && ./configure \
    && make \
    && make install \
    && cd / \
    && rm -rf git-2.17.1 \
    && git --version

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
RUN sed -i 's/python3/python2.7/1' /usr/bin/lsb_release \
    && curl -k -L -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
    && python /tmp/get-pip.py \
    && python3 /tmp/get-pip.py
ENV PATH=/usr/local/python3.7.4/bin:$PATH

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]
