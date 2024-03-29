ARG BUILD_FROM=public.ecr.aws/docker/library/centos:7
FROM ${BUILD_FROM}

RUN yum install epel-release -y && yum update -y
RUN yum install -y autoconf \
                   bison-devel \
                   curl \
                   flex-devel \
                   jq \
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

RUN yum install -y \
    krb5-workstation \
    cyrus-sasl-devel \
    cyrus-sasl \
    cyrus-sasl-gssapi


# The following is not necessary for Kerberos authentication but makes testing
# https://github.com/kafka4beam/sasl_auth easier
RUN yum install -y \
    krb5-server \
    expect

RUN yum groupinstall -y "Development Tools" \
    && yum install -y centos-release-scl \
    && yum install -y devtoolset-8-gcc devtoolset-8-gcc-c++

ADD install-openssl11.sh get-git.sh get-automake.sh get-cmake.sh /

WORKDIR /

RUN /install-openssl11.sh

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

RUN env OPENSSL_ROOT_DIR=/usr/local/openssl /get-cmake.sh build

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

ENV BASH_ENV=/opt/rh/devtoolset-8/enable \
    ENV=/opt/rh/devtoolset-8/enable \
    PROMPT_COMMAND=". /opt/rh/devtoolset-8/enable"

# Elixir complains if runs without UTF-8
# CentOS 7, exceptionally, has an `en_US.UTF-8` override as does not
# have `C.UTF-8`.
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

# merge the two dirs
ENV ACLOCAL_PATH=/usr/share/aclocal:/usr/local/share/aclocal

CMD [ "/bin/bash" ]
