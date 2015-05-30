FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# The cross-compiling emulator
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
  apt-get install -y \
    default-jre \
    nodejs \
    python2.7

ENV EMSCRIPTEN_VERSION 1.33.0
RUN cd /usr && \
  curl -L https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz | tar xz && \
  cd ./emsdk_portable && \
  ./emsdk update && \
  ./emsdk install -j$(nproc) --build=Release sdk-master-64bit && \
  ./emsdk activate --build=Release sdk-master-64bit && \
  find . -name "*.o" -exec rm {} \; && \
  find . -name "*.a" -exec rm {} \; && \
  find . -name "*.tmp" -exec rm {} \;

ENV PATH /usr/emsdk_portable:/usr/emsdk_portable/clang/fastcomp/build_master_64/bin:/usr/emsdk_portable/emscripten/master:${PATH}

ENV CMAKE_TOOLCHAIN_FILE /usr/emsdk_portable/emscripten/master/cmake/Modules/Platform/Emscripten.cmake
