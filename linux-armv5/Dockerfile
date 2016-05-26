FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# This is for ARMv5 "legacy" devices which do not support hard float VFP instructions.
# https://wiki.debian.org/CrossToolchains
RUN dpkg --add-architecture armel && \
    apt-get update && \
    apt-get install -y crossbuild-essential-armel

# The cross-compiling emulator
RUN apt-get update && apt-get install -y \
  qemu-user \
  qemu-user-static

ENV CROSS_TRIPLE arm-linux-gnueabi
ENV CROSS_ROOT /usr/bin
ENV AS=/usr/bin/${CROSS_TRIPLE}-as \
    AR=/usr/bin/${CROSS_TRIPLE}-ar \
    CC=/usr/bin/${CROSS_TRIPLE}-gcc \
    CPP=/usr/bin/${CROSS_TRIPLE}-cpp \
    CXX=/usr/bin/${CROSS_TRIPLE}-g++ \
    LD=/usr/bin/${CROSS_TRIPLE}-ld

ENV QEMU_LD_PREFIX ${CROSS_ROOT}/libc
ENV QEMU_SET_ENV "LD_LIBRARY_PATH=${CROSS_ROOT}/lib:${CROSS_ROOT}/libc/lib/${CROSS_TRIPLE}/"
