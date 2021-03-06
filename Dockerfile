FROM ubuntu:lucid

ENV ZBS_ARCH amd64
ENV ZBS_BUILDER_TYPE tgz2
ENV GIT_DEPTH 1

RUN sed -i 's/archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y autoconf libtool ssh sshpass libcurl4-openssl-dev wget xz-utils zlib1g-dev gettext gcc g++ make libmpc-dev libmpfr-dev
COPY gcc-7.3.0.tar.xz /usr/src/gcc-7.3.0.tar.xz
RUN cd /usr/src && tar xvf gcc-7.3.0.tar.xz
RUN mkdir -p /usr/src/gcc-7.3.0/build && cd /usr/src/gcc-7.3.0/build && ../configure --disable-multilib --enable-languages=c,c++ && make && make install && cd / && rm -rf /usr/src/gcc-7.3.0/
RUN update-alternatives --install /usr/bin/cc cc /usr/local/bin/gcc 100 && update-alternatives --set cc /usr/local/bin/gcc

COPY git-2.28.0.tar.gz /usr/src/git-2.28.0.tar.gz
RUN cd /usr/src && tar xvf git-2.28.0.tar.gz
RUN cd /usr/src/git-2.28.0 && ./configure && make -j4 && make install && cd / && rm -rf /usr/src/git-2.28.0/
RUN git config --global http.sslVerify false
RUN mkdir /root/.ssh/
RUN ssh-keyscan -H git.balabit >> /root/.ssh/known_hosts

RUN apt-get install -y flex bison

COPY zbs /usr/src/zbs
RUN ln -s /usr/src/zbs/lib/zbs-get.py /usr/local/bin/zbs-get
COPY sources.py /usr/src/zbs/lib/sources.py
