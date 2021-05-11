#!/bin/sh
set -e

if [ $# -eq 0 ]; then
    echo -e "Mandatory argument is missing.\nUsage: $0 <image_tag>"
    exit 1
fi

git clone git@git.balabit:tools/zbs.git
docker build --rm --no-cache -t "docker.balabit/syslog-ng/glib-glibc2.11-builder:"$1 .
