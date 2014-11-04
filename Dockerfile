FROM debian:wheezy
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

RUN apt-get update && apt-get -y install \
                        bash \
                        curl \
                        pkg-config \
                        build-essential \
                        file \
                        rsync \
                        tar \
                        xz-utils \
                        bzip2 \
                        gzip \
                        sed
