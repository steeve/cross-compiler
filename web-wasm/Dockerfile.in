FROM trzeci/emscripten-slim:sdk-tag-1.38.24-64bit
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# Revert back to "/bin/sh" as default shell
# See https://github.com/asRIA/emscripten-docker/blob/master/Dockerfile.in#L4
RUN rm /bin/sh && ln -s /bin/dash /bin/sh

COPY imagefiles/install-gosu-binary-wrapper.sh /buildscripts/

ARG DEBIAN_FRONTEND=noninteractive
ARG REPO=http://cdn-fastly.deb.debian.org

RUN \
  bash -c "echo \"deb $REPO/debian stretch main contrib non-free\" > /etc/apt/sources.list"  && \
  bash -c "echo \"deb $REPO/debian stretch-updates main contrib non-free\" >> /etc/apt/sources.list"  && \
  bash -c "echo \"deb $REPO/debian-security stretch/updates main\" >> /etc/apt/sources.list" && \
  bash -c "echo \"deb http://ftp.debian.org/debian stretch-backports main\" >> /etc/apt/sources.list" && \
  apt-get update --yes && \
  apt-get install --no-install-recommends --yes \
    automake \
    autogen \
    bash \
    build-essential \
    bc \
    bzip2 \
    ca-certificates \
    curl \
    dirmngr \
    file \
    gettext \
    gnupg2 \
    gosu \
    gzip \
    zip \
    make \
    ncurses-dev \
    pkg-config \
    libtool \
    python \
    python-pip \
    rsync \
    sed \
    ssh \
    bison \
    flex \
    tar \
    pax \
    vim \
    wget \
    xz-utils \
    zlib1g-dev \
  && \
  apt-get clean --yes && \
  /buildscripts/install-gosu-binary-wrapper.sh && \
  rm -rf /buildscripts

#include "common.docker"

ENV EMSCRIPTEN_VERSION 1.38.24

ENV PATH /emsdk_portable:/emsdk_portable/llvm/clang/bin/:/emsdk_portable/sdk/:${PATH}
ENV CC=/emsdk_portable/sdk/emcc \
  CXX=/emsdk_portable/sdk/em++ \
  AR=/emsdk_portable/sdk/emar


ENV CMAKE_TOOLCHAIN_FILE /emsdk_portable/sdk/cmake/Modules/Platform/Emscripten.cmake

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE=dockcross/web-wasm
ARG VERSION=latest
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"
ENV DEFAULT_DOCKCROSS_IMAGE ${IMAGE}:${VERSION}
