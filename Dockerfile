FROM ubuntu:lucid

ENV ZBS_ARCH amd64
ENV ZBS_BUILDER_TYPE tgz2
ENV GIT_DEPTH 1

RUN sed -i 's/archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y autoconf libtool ssh sshpass libcurl4-openssl-dev wget xz-utils zlib1g-dev gettext gcc g++ make libisl-dev libmpc-dev libgmp-dev libmpfr-dev
RUN wget http://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz && mv /gcc-7.3.0.tar.xz /usr/src/
RUN cd /usr/src && tar xvf tar xvf gcc-7.3.0.tar.xz
RUN mkdir -p /usr/src/gcc-7.3.0/build && cd /usr/src/gcc-7.3.0/build && ../configure --disable-multilib --enable-languages=c,c++ && make && make install && cd / && rm -rf /usr/src/gcc-7.3.0/
RUN update-alternatives --install /usr/bin/cc cc /usr/local/bin/gcc 100 && update-alternatives --set cc /usr/local/bin/gcc

RUN wget --no-check-certificate http://www.kernel.org/pub/software/scm/git/git-2.28.0.tar.gz -P /usr/src
RUN cd /usr/src && tar xvf git-2.28.0.tar.gz
RUN cd /usr/src/git-2.28.0 && ./configure && make -j4 && make install && cd / && rm -rf /usr/src/git-2.28.0/
RUN git config --global http.sslVerify false
RUN ssh-keyscan -H git.balabit >> /root/.ssh/known_hosts

RUN cd /usr/src && git clone https://git.balabit/tools/zbs.git
RUN ln -s /usr/src/zbs/lib/zbs-get.py /usr/local/bin/zbs-get
COPY sources.py /usr/src/zbs/lib/
