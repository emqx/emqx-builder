ARG BUILD_FROM=debian:11
FROM ${BUILD_FROM}

RUN apt-get update && apt-get install -y \
    procps \
    git \
    wget \
    zip \
    unzip \
    vim \
    build-essential \
    debhelper \
    curl \
    libssl-dev \
    automake \
    autoconf \
    libncurses5-dev \
    gcc \
    g++ \
    make \
    zlib1g-dev \
    libffi-dev \
    unixodbc \
    unixodbc-dev \
    jq \
    python3 \
    python3-pip

RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

# cleanup
RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /
CMD [ "/bin/bash" ]
