FROM steeve/cross-compiler:base
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

ENV CROSS_TRIPLE arm-linux-gnueabihf
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV PATH ${PATH}:${CROSS_ROOT}/bin
ENV LD_LIBRARY_PATH ${CROSS_ROOT}/lib:${LD_LIBRARY_PATH}
ENV RASPBERRYPI_TOOLS_COMMIT 9c3d7b6ac692498dd36fec2872e0b55f910baac1

# Enable 32 bits binaries
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386

# Raspberry Pi is ARMv6+VFP2, Debian armhf is ARMv7+VFP3
# Since this Dockerfile is targeting linux-arm from Raspberry Pi onward,
# we're sticking with it's custom built cross-compiler with hardfp support.
# We could use Debian's armel, but we'd have softfp and loose a good deal
# of performance.
# See: https://wiki.debian.org/RaspberryPi
# We are also using the 4.7 version of the toolchain, so that glibc=2.13
RUN curl -L https://github.com/raspberrypi/tools/archive/${RASPBERRYPI_TOOLS_COMMIT}.tar.gz | tar xvz --wildcards --no-anchored "*gcc-linaro-${CROSS_TRIPLE}-raspbian*" && \
    rsync -av /tools-${RASPBERRYPI_TOOLS_COMMIT}/arm-bcm2708/gcc-linaro-${CROSS_TRIPLE}-raspbian/* /usr && \
    cd /usr/bin && \
    ln -s ${CROSS_TRIPLE}-gcc ${CROSS_TRIPLE}-cc && \
    rm -rf /tools-${RASPBERRYPI_TOOLS_COMMIT}
