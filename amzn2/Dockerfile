ARG BUILD_FROM=public.ecr.aws/amazonlinux/amazonlinux:2
FROM ${BUILD_FROM}

ARG TARGETPLATFORM
COPY amzn2/RPM-GPG-KEY* /etc/pki/rpm-gpg/
COPY amzn2/yum.repos.d/${TARGETPLATFORM}/* /etc/yum.repos.d/

RUN yum clean all && \
    yum makecache && \
    yum update -y && \
    yum install -y wget && \
    if [ $(arch) == "x86_64" ]; then \
        wget https://vault.centos.org/7.9.2009/os/x86_64/Packages/libgfortran5-8.3.1-2.1.1.el7.x86_64.rpm; \
    else \
        wget https://vault.centos.org/altarch/7/os/aarch64/Packages/libgfortran5-8.3.1-2.1.1.el7.aarch64.rpm; \
    fi && \
    yum install -y libgfortran5-8.3.1-2.1.1.el7.*.rpm

RUN yum update -y && \
    yum groupinstall -y "Development Tools" && \
    yum install -y curl \
                   cyrus-sasl \
                   cyrus-sasl-devel \
                   cyrus-sasl-gssapi \
                   devtoolset-10-gcc \
                   devtoolset-10-gcc-c++ \
                   expect \
                   git \
                   jq \
                   krb5-server \
                   krb5-workstation \
                   ncurses-devel \
                   openssl11 \
                   openssl11-devel \
                   python3 \
                   python3-pip \
                   systemd \
                   unixODBC \
                   unixODBC-devel \
                   vim \
                   wget \
                   which

WORKDIR /

ADD get-cmake.sh get-automake.sh  /

RUN yum remove -y automake && /get-automake.sh && rm /get-automake.sh

RUN /get-cmake.sh build && rm /get-cmake.sh

RUN alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
    alternatives --install /usr/bin/python python /usr/bin/python3 2 && \
    alternatives --set python /usr/bin/python3 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip2 1 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip3 2 && \
    alternatives --set pip /usr/bin/pip3 && \
    sed 's/python/python2/g' -i /usr/bin/yum

# cleanup
RUN yum clean packages && \
    rm -rf /tmp/* /var/tmp/* /var/cache/yum

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install Rustup to a system-wide location
ENV RUSTUP_HOME=/usr/local/lib/rustup
ENV CARGO_HOME=/usr/local/cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none
ENV PATH="/usr/local/cargo/bin:${PATH}"

CMD [ "/bin/bash" ]
