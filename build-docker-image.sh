#!/bin/sh
set -e

if [ $# -eq 0 ]; then
    echo -e "Mandatory argument is missing.\nUsage: $0 <image_tag>"
    exit 1
fi

git clone git@git.balabit:tools/zbs.git
wget http://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz
wget https://www.kernel.org/pub/software/scm/git/git-2.28.0.tar.gz

docker build --rm --no-cache -t "docker.balabit/syslog-ng/glib-glibc2.11-builder:"$1 .
