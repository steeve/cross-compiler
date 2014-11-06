# Can't use steeve/cross-compiler:base because gcc-linaro-arm-linux-gnueabihf-raspbian
# requires GLIBC 2.14 and we have 2.13 on wheezy.
FROM debian:jessie
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

RUN apt-get update && apt-get -y install \
                        bash \
                        curl wget \
                        pkg-config build-essential make automake autogen \
                        tar xz-utils bzip2 gzip \
                        file \
                        rsync \
                        sed \
                        vim

ENV CROSS_TRIPLE arm-linux-gnueabihf
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV PATH ${PATH}:${CROSS_ROOT}/bin
ENV LD_LIBRARY_PATH ${CROSS_ROOT}/lib:${LD_LIBRARY_PATH}

# Raspberry Pi is ARMv6+VFP2, Debian armhf is ARMv7+VFP3
# Since this Dockerfile is targeting linux-arm from Raspberry Pi onward,
# we're sticking with it's custom built cross-compiler with hardfp support.
# We could use Debian's armel, but we'd have softfp and loose a good deal
# of performance.
# See: https://wiki.debian.org/RaspberryPi
RUN curl -L https://github.com/raspberrypi/tools/archive/master.tar.gz | tar xvz --wildcards --no-anchored "*gcc-linaro-${CROSS_TRIPLE}-raspbian-x64*" && \
    rsync -av /tools-master/arm-bcm2708/gcc-linaro-${CROSS_TRIPLE}-raspbian-x64/* /usr && \
    cd /usr/bin && \
    ln -s ${CROSS_TRIPLE}-gcc ${CROSS_TRIPLE}-cc && \
    rm -rf /tools-master
