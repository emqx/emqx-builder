ARG BUILD_FROM=public.ecr.aws/docker/library/alpine:3.15.1
FROM ${BUILD_FROM}

RUN apk add --no-cache --virtual .build-deps \
                autoconf \
                automake \
                bash \
                bison \
                bsd-compat-headers \
                ca-certificates \
                coreutils \
                curl \
                cyrus-sasl-dev \
                cyrus-sasl-gssapiv2 \
                dpkg-dev dpkg \
                flex \
                g++ \
                gcc \
                git \
                jq \
                krb5 \
                krb5-dev \
                krb5-libs \
                libc-dev \
                libffi-dev \
                libsasl \
                libtool \
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
                zlib-dev \
                krb5-server \
                expect


RUN ln -s /usr/bin/python3 /usr/bin/python

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

CMD [ "/bin/sh" ]
