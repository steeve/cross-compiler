FROM dockcross/base:latest
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"
#include "common.crosstool"

# Add sources.list
COPY sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
  crossbuild-essential-arm64 \
  gfortran-aarch64-linux-gnu \
  libbz2-dev:arm64 \
  libexpat1-dev:arm64 \
  ncurses-dev:arm64 \
  libssl-dev:arm64

WORKDIR /usr/src

RUN apt-get update && \
  apt-get install -y libglib2.0-dev zlib1g-dev libpixman-1-dev && \
  curl -L http://wiki.qemu-project.org/download/qemu-2.6.0.tar.bz2 | tar xj && \
  cd qemu-2.6.0 && \
  ./configure --target-list=aarch64-linux-user --prefix=/usr && \
  make -j$(nproc) && \
  make install && \
  cd .. && rm -rf qemu-2.6.0

ENV CROSS_TRIPLE aarch64-unknown-linux-gnueabi
ENV CROSS_ROOT /opt/x-tools/${CROSS_TRIPLE}
ENV AS=/opt/x-tools/${CROSS_TRIPLE}-as \
    AR=/opt/x-tools/${CROSS_TRIPLE}-ar \
    CC=/opt/x-tools/${CROSS_TRIPLE}-gcc \
    CPP=/opt/x-tools/${CROSS_TRIPLE}-cpp \
    CXX=/opt/x-tools/${CROSS_TRIPLE}-g++ \
    LD=/opt/x-tools/${CROSS_TRIPLE}-ld

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/linux-arm64
WORKDIR /work

# Note: Toolchain file support is currently in debian Experimental according to:
# https://wiki.debian.org/CrossToolchains#In_jessie_.28Debian_8.29
# We can switch to that when it becomes stable.
COPY Toolchain.cmake /usr/lib/${CROSS_TRIPLE}/
ENV CMAKE_TOOLCHAIN_FILE /usr/lib/${CROSS_TRIPLE}/Toolchain.cmake

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"

ENV PKG_CONFIG_PATH /usr/lib/aarch64-linux-gnu/pkgconfig
