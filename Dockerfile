ARG BUILD_FROM=public.ecr.aws/ubuntu/ubuntu:22.04
FROM ${BUILD_FROM}

ENV EMQX_BUILDER_IMAGE=${BUILD_FROM}
ENV ERL_AFLAGS="-kernel shell_history enabled"

ARG BUILD_WITHOUT_QUIC=false
ARG OTP_VERSION=27.2-2
ARG ELIXIR_VERSION=1.17.3
ARG FDB_VERSION=7.3.43
ARG EMQTT_BENCH_VERSION=0.4.25
ARG LUX_VERSION=lux-3.0

COPY get-otp.sh get-zsh.sh get-elixir.sh get-fdb.sh get-emqtt-bench.sh get-lux.sh /

RUN if [ -f /opt/rh/devtoolset-10/enable ]; then source /opt/rh/devtoolset-10/enable; fi && \
    . /etc/os-release && export ID=$ID && export VERSION_ID=$VERSION_ID && \
    if expr "${OTP_VERSION}" : '24' > /dev/null && [ "${ID}" = "ubuntu" ] && [ "${VERSION_ID}" = "18.04" ]; then update-alternatives --set gcc /usr/bin/gcc-7; fi && \
    which gcc && gcc --version && \
    which g++ && g++ --version && \
    /get-zsh.sh && \
    /get-otp.sh ${OTP_VERSION} && \
    /get-elixir.sh ${ELIXIR_VERSION} && \
    /get-fdb.sh ${FDB_VERSION} && \
    /get-emqtt-bench.sh ${EMQTT_BENCH_VERSION} && \
    /get-lux.sh ${LUX_VERSION} && \
    rm /get-otp.sh /get-zsh.sh /get-elixir.sh /get-fdb.sh /get-emqtt-bench.sh /get-lux.sh

WORKDIR /
CMD [ "/bin/zsh" ]
