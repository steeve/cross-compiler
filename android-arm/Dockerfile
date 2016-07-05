FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# The cross-compiling emulator
RUN apt-get update && apt-get install -y \
  qemu-user \
  qemu-user-static

ENV CROSS_TRIPLE=arm-linux-androideabi
ENV CROSS_ROOT=/usr/${CROSS_TRIPLE}
ENV AS=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-as \
    AR=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ar \
    CC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gcc \
    CPP=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-cpp \
    CXX=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-g++ \
    LD=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ld

ENV ANDROID_NDK_REVISION 10e
RUN mkdir -p /build && \
    cd /build && \
    curl -O http://dl.google.com/android/ndk/android-ndk-r${ANDROID_NDK_REVISION}-linux-x86_64.bin && \
    chmod +x ./android-ndk-r${ANDROID_NDK_REVISION}-linux-x86_64.bin && \
    ./android-ndk-r${ANDROID_NDK_REVISION}-linux-x86_64.bin && \
    cd /build/android-ndk-r${ANDROID_NDK_REVISION} && \
    /bin/bash ./build/tools/make-standalone-toolchain.sh \
      --arch=arm \
      --system=linux-x86_64 \
      --ndk-dir=/build/android-ndk-r${ANDROID_NDK_REVISION} \
      --platform=android-14 \
      --install-dir=${CROSS_ROOT} && \
    cd / && \
    rm -rf /build && \
    find ${CROSS_ROOT} -exec chmod a+r '{}' \; && \
    find ${CROSS_ROOT} -executable -exec chmod a+x '{}' \;


ENV DEFAULT_DOCKCROSS_IMAGE thewtex/cross-compiler-android-arm

COPY Toolchain.cmake ${CROSS_ROOT}/
ENV CMAKE_TOOLCHAIN_FILE ${CROSS_ROOT}/Toolchain.cmake
