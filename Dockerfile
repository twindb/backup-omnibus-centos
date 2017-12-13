FROM centos:centos6
MAINTAINER Maksym Kryva @mkryva

RUN yum -y install epel-release
RUN yum groupinstall -y 'Development Tools'
RUN yum -y install centos-release-scl

RUN yum install -y \
    which \
    openssl-devel \
    expat-devel \
    perl-ExtUtils-MakeMaker \
    perl-devel \
    curl-devel \
    gettext-devel \
    zlib-devel \
    wget \
    fakeroot \
    gcc \
    python27 \
    cmake
RUN yum remove -y git
RUN cd /usr/src ; wget https://www.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz ; tar xzf git-2.9.5.tar.gz ; cd git-2.9.5 ; make prefix=/usr/local/git all ; make prefix=/usr/local/git install
RUN cat /opt/rh/python27/enable >> /root/.bashrc
RUN echo 'export PATH=$PATH:/usr/local/git/bin' >> /root/.bashrc
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable

RUN bash -lc "rvm requirements; \
        rvm install 2.2.2 ; \
        gem install bundler --no-ri --no-rdoc;\
        "

RUN rm -rf /usr/local/rvm/src/ruby-2.2.2
CMD /bin/bash -l