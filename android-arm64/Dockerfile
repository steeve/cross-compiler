FROM dockcross/base:latest
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"
RUN dpkg --add-architecture arm64 ; apt-get update

# The cross-compiling emulator
RUN apt-get update && apt-get install -y \
  qemu-user \
  qemu-user-static \
  unzip

ENV CROSS_TRIPLE=aarch64-linux-android
ENV CROSS_ROOT=/usr/${CROSS_TRIPLE}
ENV AS=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-as \
    AR=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ar \
    CC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-clang \
    CPP=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-cpp \
    CXX=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-clang++ \
    LD=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ld \
    FC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gfortran

ENV ANDROID_NDK_REVISION 16b
ENV ANDROID_NDK_API 21
RUN mkdir -p /build && \
    cd /build && \
    curl -O https://dl.google.com/android/repository/android-ndk-r${ANDROID_NDK_REVISION}-linux-x86_64.zip && \
    unzip ./android-ndk-r${ANDROID_NDK_REVISION}-linux-x86_64.zip && \
    cd android-ndk-r${ANDROID_NDK_REVISION} && \
    ./build/tools/make_standalone_toolchain.py \
      --arch arm64 \
      --api ${ANDROID_NDK_API} \
      --stl=libc++ \
      --install-dir=${CROSS_ROOT} && \
    cd / && \
    rm -rf /build && \
    find ${CROSS_ROOT} -exec chmod a+r '{}' \; && \
    find ${CROSS_ROOT} -executable -exec chmod a+x '{}' \;


ENV DEFAULT_DOCKCROSS_IMAGE dockcross/android-arm64

COPY Toolchain.cmake ${CROSS_ROOT}/
ENV CMAKE_TOOLCHAIN_FILE ${CROSS_ROOT}/Toolchain.cmake

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
