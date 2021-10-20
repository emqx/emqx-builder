ARG BUILD_FROM=centos:6
FROM ${BUILD_FROM}

ADD centos6/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum install epel-release -y && yum update -y
RUN yum install -y http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm \
    && yum install -y git
RUN yum install -y wget zip which curl unzip vim ncurses-devel openssl-devel unixODBC-devel jq libatomic
RUN yum groupinstall -y "Development Tools"

# Install gcc-8 from centos vault repo
RUN yum install -y centos-release-scl && \
    sed -i 's/mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo && \
    sed -i 's/#.*baseurl=/baseurl=/g' /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo && \
    sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo && \
    sed -i 's/mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/CentOS-SCLo-scl.repo && \
    sed -i 's/#.*baseurl=/baseurl=/g' /etc/yum.repos.d/CentOS-SCLo-scl.repo && \
    sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/CentOS-SCLo-scl.repo && \
    yum install -y devtoolset-8-gcc devtoolset-8-gcc-c++

WORKDIR /

RUN yum install -y openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel gcc gcc-c++ openssl-devel \
    && wget https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz \
    && tar xvf Python-3.6.7.tgz \
    && cd Python-3.6.7 \
    && echo "_socket socketmodule.c" >> Modules/Setup.dist \
    && echo "_ssl _ssl.c -DUSE_SSL -I/usr/local/ssl/include -I/usr/local/ssl/include/openssl -L/usr/local/ssl/lib -lssl -lcrypto" >> Modules/Setup.dist \
    && ./configure --prefix=/usr/local/python3.6.7 \
    && make \
    && make install \
    && rm -rf /usr/bin/python3 /usr/bin/pip3 /usr/bin/pip \
    && ln -s /usr/local/python3.6.7/bin/python3.6 /usr/bin/python3 \
    && ln -s /usr/local/python3.6.7/bin/pip3 /usr/bin/pip3 \
    && ln -s /usr/local/python3.6.7/bin/pip /usr/bin/pip
    # && rm -rf /usr/bin/python3 /usr/bin/python \
    # && ln -s /usr/local/python3.6.7/bin/python3.6 /usr/bin/python3 \
    # && ln -s /usr/local/python3.6.7/bin/python3.6 /usr/bin/python \
    # && sed -i "s/python/python2.6/g" /usr/bin/yum
ENV PATH=/usr/local/python3.6.7/bin:$PATH

COPY get-cmake.sh /get-cmake.sh
RUN /get-cmake.sh download
ENV PATH=/cmake/bin:$PATH
RUN cmake --version

# cleanup
RUN yum clean packages \
 && rm -rf /tmp/* /var/tmp/*

ENV BASH_ENV=/opt/rh/devtoolset-8/enable \
     ENV=/opt/rh/devtoolset-8/enable \
     PROMPT_COMMAND=". /opt/rh/devtoolset-8/enable"

WORKDIR /
CMD [ "/bin/bash" ]
