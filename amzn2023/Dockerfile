ARG BUILD_FROM=public.ecr.aws/amazonlinux/amazonlinux:2023
FROM ${BUILD_FROM}

RUN dnf -y update && \
    dnf -y groupinstall development && \
    dnf -y install \
      cmake \
      cyrus-sasl \
      cyrus-sasl-devel \
      cyrus-sasl-gssapi \
      expect \
      jq \
      krb5-devel \
      krb5-server \
      krb5-workstation \
      libatomic \
      ncurses-devel \
      openssl-devel \
      perl \
      python3-pip \
      unixODBC \
      unixODBC-devel \
      vim \
      wget && \
    dnf clean all && \
    rm -rf /tmp/* /var/tmp/* /var/cache/dnf

RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /

# Elixir complains if runs without UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD [ "/bin/bash" ]
