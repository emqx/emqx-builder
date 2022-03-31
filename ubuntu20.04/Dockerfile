ARG BUILD_FROM=ubuntu:20.04
FROM ${BUILD_FROM}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    zip \
    unzip \
    vim \
    build-essential \
    debhelper \
    libssl-dev \
    automake \
    autoconf \
    libncurses5-dev \
    gcc \
    g++ \
    make \
    cmake \
    zlib1g-dev \
    libffi-dev \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    jq \
    flex \
    bison \
    python3 \
    python3-pip

RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

RUN cmake --version

RUN apt-get update &&  apt-get install -y unixodbc unixodbc-dev

WORKDIR /


# cleanup
RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]
