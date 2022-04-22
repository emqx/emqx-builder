FROM opensuse/tumbleweed:latest

RUN zypper install -y wget tar git curl vim zip unzip gcc gcc-c++ make ncurses-devel openssl-devel rsyslog rpm-build python python3 python3-pip cmake autoconf jq flex bison automake

RUN cmake --version
RUN zypper install -y unixODBC unixODBC-devel

WORKDIR /

CMD [ "/bin/bash" ]
