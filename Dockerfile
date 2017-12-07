FROM centos:centos6
MAINTAINER Maksym Kryva @mkryva

RUN yum -y install epel-release
RUN yum groupinstall -y 'Development Tools'
RUN yum -y install centos-release-scl

RUN yum install -y \
    git \
    which \
    openssl-devel \
    expat-devel \
    perl-ExtUtils-MakeMaker \
    perl-devel \
    zlib-devel \
    fakeroot \
    gcc \
    python27 \
    cmake

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable

RUN bash -lc "rvm requirements; \
        rvm install 2.2.2 ; \
        gem install bundler --no-ri --no-rdoc;\
        "

RUN rm -rf /usr/local/rvm/src/ruby-2.2.2
RUN scl enable python27 bash

CMD /bin/bash -l