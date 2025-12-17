ARG BUILD_FROM=centos:7
FROM ${BUILD_FROM}
ARG TARGETPLATFORM

COPY el7/RPM-GPG-KEY-CentOS-SIG-SCLo /etc/pki/rpm-gpg/
COPY el7/yum.repos.d/${TARGETPLATFORM}/* /etc/yum.repos.d/

RUN yum clean all && \
    yum makecache && \
    yum install epel-release -y && yum update -y

RUN yum groupinstall -y "Development Tools" && \
    yum install -y autoconf \
                   bison-devel \
                   centos-release-scl \
                   curl \
                   cyrus-sasl \
                   cyrus-sasl-devel \
                   cyrus-sasl-gssapi \
                   devtoolset-10-gcc \
                   devtoolset-10-gcc-c++ \
                   expect \
                   flex-devel \
                   jq \
                   krb5-server \
                   krb5-workstation \
                   libatomic \
                   libtool \
                   ncurses-devel \
                   python3 \
                   python3-pip \
                   systemd \
                   unixODBC-devel \
                   unzip \
                   vim \
                   wget \
                   which \
                   zip \
                   zlib-devel

ADD install-openssl11.sh get-git.sh get-automake.sh get-cmake.sh /

COPY el9/get-protoc.sh /get-protoc.sh

RUN /get-protoc.sh

WORKDIR /

# We need git >= 2.18 otherwise actions/checkout@v3 in github
# workflows will use REST API to download source code archive without
# .git directory instead of normal git clone. And if release is
# configured to take it's version from git tag, rebar3 will not be
# able to resolve the version correctly and will fallback to 0.0.0,
# like it happened with emqtt-bench.
# The error from actions/checkout@v3 is as follows:
# > The repository will be downloaded using the GitHub REST API
# > To create a local Git repository instead, add Git 2.18 or higher to the PATH

# - have to uninstall stock git to cleanup all git backend files,
#   otherwise git from the newer version may encounter
#   an error like "bogus format in GIT_CONFIG_PARAMETERS"
# - gnu99 flag is to address https://gitlab.com/gitlab-org/omnibus-gitlab/-/merge_requests/5948
# - libcurl-devel is needed to support clone from https remotes
RUN yum remove -y git* \
    && yum install -y libcurl-devel \
    && env DEVELOPER_CFLAGS='-std=gnu99' /get-git.sh \
    && git --version

RUN /get-automake.sh
RUN /install-openssl11.sh
ENV OPENSSL_ROOT_DIR=/usr/local/openssl
RUN /get-cmake.sh build

# We have to reinstall `glibc-common` after removing the override just
# for the `arm64` platform build of CentOS 7.  While just setting the
# locale works for `amd64`, even `en_US.UTF-8`, which is in the
# override for `arm64`, is not available...
RUN sed -i -e '/override_install_langs/d' /etc/yum.conf && \
    yum -q -y reinstall glibc-common

RUN alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
    alternatives --install /usr/bin/python python /usr/bin/python3 2 && \
    alternatives --set python /usr/bin/python3 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip2 1 && \
    alternatives --install /usr/bin/pip pip /usr/bin/pip3 2 && \
    alternatives --set pip /usr/bin/pip3 && \
    sed 's/python/python2/g' -i /usr/bin/yum

# cleanup
RUN yum clean packages && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm /install-openssl11.sh /get-git.sh /get-automake.sh /get-cmake.sh

ENV BASH_ENV=/opt/rh/devtoolset-10/enable \
    ENV=/opt/rh/devtoolset-10/enable \
    PROMPT_COMMAND=". /opt/rh/devtoolset-10/enable"

# Elixir complains if runs without UTF-8
# CentOS 7, exceptionally, has an `en_US.UTF-8` override as does not
# have `C.UTF-8`.
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

# merge the two dirs
ENV ACLOCAL_PATH=/usr/share/aclocal:/usr/local/share/aclocal

# Install Rustup to a system-wide location
ENV RUSTUP_HOME=/usr/local/lib/rustup
ENV CARGO_HOME=/usr/local/cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none
ENV PATH="/usr/local/cargo/bin:${PATH}"

CMD [ "/bin/bash" ]
