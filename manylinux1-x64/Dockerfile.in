FROM scikitbuild/manylinux1_x86_64:91cb02fb8
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/manylinux1-x64

#include "common.manylinux"

#include "common.docker"

ENV CROSS_TRIPLE x86_64-linux-gnu
ENV CROSS_ROOT /opt/rh/devtoolset-2/root/usr/bin
ENV AS=${CROSS_ROOT}/as \
    AR=${CROSS_ROOT}/ar \
    CC=${CROSS_ROOT}/gcc \
    CPP=${CROSS_ROOT}/cpp \
    CXX=${CROSS_ROOT}/g++ \
    LD=${CROSS_ROOT}/ld \
    FC=${CROSS_ROOT}/gfortran

COPY linux-x64/${CROSS_TRIPLE}-noop.sh /usr/bin/${CROSS_TRIPLE}-noop

COPY manylinux1-x64/Toolchain.cmake ${CROSS_ROOT}/../lib/
ENV CMAKE_TOOLCHAIN_FILE ${CROSS_ROOT}/../lib/Toolchain.cmake

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE=dockcross/manylinux1-x64
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
