ARG BUILD_FROM=alpine:3.14
FROM ${BUILD_FROM}

ENV PYTHON_VERSION=3.7.4

RUN apk add --no-cache --virtual .build-deps \
                autoconf \
                automake \
                bash \
                bison \
                bsd-compat-headers \
                ca-certificates \
                coreutils \
                curl \
                dpkg-dev dpkg \
                elixir \
                flex \
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
                tar \
                unixodbc-dev \
                wget \
                zip \
                zlib-dev

# install python
RUN curl -L -o /tmp/Python-${PYTHON_VERSION}.tgz https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz 
RUN rm -rf /usr/bin/python /usr/bin/python3 \
        && tar -zxvf /tmp/Python-${PYTHON_VERSION}.tgz -C /tmp \
        && cd /tmp/Python-${PYTHON_VERSION} \
        && echo "_socket socketmodule.c" >> Modules/Setup.dist \
        && echo "_ssl _ssl.c -DUSE_SSL -I/usr/local/ssl/include -I/usr/local/ssl/include/openssl -L/usr/local/ssl/lib -lssl -lcrypto" >> Modules/Setup.dist \
        && ./configure \
        && make \
        && make install \
        && ln -s /usr/local/bin/python3 /usr/bin/python3 \
        && ln -s /usr/local/bin/python3 /usr/bin/python \
        && rm -rf /tmp/Python-${PYTHON_VERSION} /tmp/Python-${PYTHON_VERSION}.tgz

RUN apk add py-pip

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh build

CMD [ "/bin/sh" ]
