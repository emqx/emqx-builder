FROM opensuse/tumbleweed:latest
ARG OTP_VERSION

RUN zypper update -y && zypper install -y wget tar git curl vim zip unzip gcc gcc-c++ make ncurses-devel openssl-devel rsyslog rpm-build python python3 python3-pip cmake autoconf jq

RUN cmake --version
RUN zypper install -y unixODBC unixODBC-devel

COPY get-otp.sh /get-otp.sh
RUN /get-otp.sh ${OTP_VERSION}

WORKDIR /

CMD [ "/bin/bash" ]
