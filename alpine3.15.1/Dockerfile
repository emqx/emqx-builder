ARG BUILD_FROM=alpine:3.15.1
FROM ${BUILD_FROM}

RUN apk add --no-cache --virtual .build-deps \
                ca-certificates \
                zip \
                dpkg-dev dpkg \
                gcc \
                g++ \
                libc-dev \
                linux-headers \
                make \
                autoconf \
                ncurses-dev \
                openssl-dev \
                unixodbc-dev \
                lksctp-tools-dev \
                tar \
                git \
                wget \
                curl \
                bsd-compat-headers \
                coreutils \
                openssh-client \
                openssh-keygen \
                zlib-dev \
                libffi-dev \
                elixir \
                openjdk8 \
                bash \
                jq \
                python3 \
                py3-pip

RUN ln -s /usr/bin/python3 /usr/bin/python

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

CMD [ "/bin/sh" ]
