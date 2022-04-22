ARG BUILD_FROM=alpine:3.15.1
FROM ${BUILD_FROM}

RUN apk add --no-cache --virtual .build-deps \
                autoconf \
                automake \
                bash \
                bsd-compat-headers \
                ca-certificates \
                coreutils \
                curl \
                dpkg-dev dpkg \
                g++ \
                gcc \
                git \
                jq \
                libc-dev \
                libffi-dev \
                linux-headers \
                lksctp-tools-dev \
                make \
                ncurses-dev \
                openjdk8 \
                openssh-client \
                openssh-keygen \
                openssl-dev \
                py3-pip \
                python3 \
                tar \
                unixodbc-dev \
                wget \
                zip \
                zlib-dev

RUN ln -s /usr/bin/python3 /usr/bin/python

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

CMD [ "/bin/sh" ]
