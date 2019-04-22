FROM debian:stretch-20190326-slim
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

#include "common.debian"
# Image build scripts
COPY imagefiles/install-gosu-binary.sh /buildscripts/

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
    gzip \
    gnupg \
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
  /buildscripts/install-gosu-binary.sh && \
  rm -rf /buildscripts

#include "common.docker"
WORKDIR /usr/src

ARG GIT_VERSION=2.20.1
ARG CMAKE_VERSION=3.13.2

# Image build scripts
COPY \
  imagefiles/build-and-install-cmake.sh \
  imagefiles/build-and-install-curl.sh \
  imagefiles/build-and-install-git.sh \
  imagefiles/build-and-install-ninja.sh \
  imagefiles/build-and-install-openssl.sh \
  imagefiles/build-and-install-openssh.sh \
  imagefiles/install-cmake-binary.sh \
  imagefiles/install-liquidprompt-binary.sh \
  imagefiles/install-python-packages.sh \
  imagefiles/utils.sh \
  /buildscripts/

RUN \
  X86_FLAG=$([ "$DEFAULT_DOCKCROSS_IMAGE" = "dockcross/manylinux-x86" ] && echo "-32" || echo "") && \
  /buildscripts/build-and-install-openssl.sh $X86_FLAG && \
  /buildscripts/build-and-install-openssh.sh && \
  /buildscripts/build-and-install-curl.sh && \
  /buildscripts/build-and-install-git.sh && \
  /buildscripts/install-cmake-binary.sh $X86_FLAG && \
  /buildscripts/install-liquidprompt-binary.sh && \
  PYTHON=$([ -e /opt/python/cp35-cp35m/bin/python ] && echo "/opt/python/cp35-cp35m/bin/python" || echo "python") && \
  /buildscripts/install-python-packages.sh -python ${PYTHON} && \
  /buildscripts/build-and-install-ninja.sh -python ${PYTHON} && \
  rm -rf /buildscripts

RUN echo "root:root" | chpasswd
WORKDIR /work
ENTRYPOINT ["/dockcross/entrypoint.sh"]

# Runtime scripts
COPY imagefiles/cmake.sh /usr/local/bin/cmake
COPY imagefiles/ccmake.sh /usr/local/bin/ccmake
COPY imagefiles/entrypoint.sh imagefiles/dockcross /dockcross/

# Build-time metadata as defined at http://label-schema.org
# Note: To avoid systematic rebuild of dependent images, only
#       name and vcs-url are included.
ARG IMAGE
ARG VCS_URL
LABEL org.label-schema.name=$IMAGE \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"
