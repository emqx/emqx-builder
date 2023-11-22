ARG BUILD_FROM=public.ecr.aws/ubuntu/ubuntu:22.04
FROM ${BUILD_FROM}

ENV EMQX_BUILDER_IMAGE=${BUILD_FROM}

ARG OTP_VERSION

COPY get-otp.sh /get-otp.sh
RUN /get-otp.sh ${OTP_VERSION}

ARG ELIXIR_VERSION

COPY get-elixir.sh /get-elixir.sh
RUN /get-elixir.sh ${ELIXIR_VERSION}

RUN mkdir /tools

ARG EMQTT_BENCH_REF

COPY get-emqtt-bench.sh /get-emqtt-bench.sh
RUN /get-emqtt-bench.sh "${EMQTT_BENCH_REF:-0.4.17}"

ARG LUX_REF
ENV LUX_REF=${LUX_REF:-lux-2.9.1}

RUN git clone --depth=1 --branch=${LUX_REF} https://github.com/hawk/lux /tools/lux \
    && cd /tools/lux \
    && autoconf \
    && ./configure \
    && make \
    && make install \
    && cd /tools \
    && rm -rf lux

WORKDIR /
CMD [ "/bin/bash" ]
