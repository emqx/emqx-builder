ARG BUILD_FROM=public.ecr.aws/ubuntu/ubuntu:22.04
FROM ${BUILD_FROM}

ENV EMQX_BUILDER_IMAGE=${BUILD_FROM}

ARG OTP_VERSION=26.2.3-1
ARG ELIXIR_VERSION=1.15.7
ARG FDB_VERSION=7.3.27
ARG EMQTT_BENCH_REF=0.4.17
ARG LUX_REF=lux-2.9.1

COPY get-otp.sh get-elixir.sh get-fdb.sh get-emqtt-bench.sh get-lux.sh /

RUN /get-otp.sh ${OTP_VERSION} && \
    /get-elixir.sh ${ELIXIR_VERSION} && \
    env FDB_VERSION=${FDB_VERSION} /get-fdb.sh && \
    env EMQTT_BENCH_REF=${EMQTT_BENCH_REF} /get-emqtt-bench.sh && \
    env LUX_REF=${LUX_REF} /get-lux.sh && \
    rm /get-otp.sh /get-elixir.sh /get-fdb.sh /get-emqtt-bench.sh /get-lux.sh

WORKDIR /
CMD [ "/bin/bash" ]
