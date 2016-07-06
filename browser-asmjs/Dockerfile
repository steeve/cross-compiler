FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# The cross-compiling emulator
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
  apt-get install -y --no-install-recommends \
    default-jre \
    nodejs \
    python2.7

ENV EMSCRIPTEN_VERSION 1.36.5
RUN cd /usr && \
  curl -L https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz | tar xz && \
  cd ./emsdk_portable && \
  ./emsdk update && \
  ./emsdk install -j$(nproc) --build=Release sdk-tag-${EMSCRIPTEN_VERSION}-32bit && \
  ./emsdk activate --build=Release sdk-tag-${EMSCRIPTEN_VERSION}-32bit && \
  ./emsdk install node-4.1.1-64bit && \
  ./emsdk activate node-4.1.1-64bit && \
  ./emsdk uninstall node-4.1.1-32bit && \
  find . -name "*.o" -exec rm {} \; && \
  find . -name "*.a" -exec rm {} \; && \
  find . -name "*.tmp" -exec rm {} \;

ENV PATH /usr/emsdk_portable:/usr/emsdk_portable/clang/tag-e${EMSCRIPTEN_VERSION}/build_tag-e${EMSCRIPTEN_VERSION}_32/bin:/usr/emsdk_portable/emscripten/tag-${EMSCRIPTEN_VERSION}:${PATH}
ENV CC=/usr/emsdk_portable/emscripten/tag-${EMSCRIPTEN_VERSION}/emcc \
  CXX=/usr/emsdk_portable/emscripten/tag-${EMSCRIPTEN_VERSION}/em++ \
  AR=/usr/emsdk_portable/emscripten/tag-${EMSCRIPTEN_VERSION}/emar

# Emscripten generates system libraries the firsts time it runs
ADD test/ /tmp/test/
RUN cd /tmp && \
  /bin/echo -e "#include <iostream>\nint main() { std::cout << \"first run\"; return 0; }" > /tmp/first_run.cxx && \
  $CXX /tmp/first_run.cxx -o a.out.js && \
  rm /tmp/first_run.* && \
  /bin/echo -e "#include <stdio.h>\nint main() { printf(\"first run\"); return 0; }" > /tmp/first_run.c && \
  $CC /tmp/first_run.c -o a.out.js && \
  rm /tmp/first_run.* a.out.js && \
  cd /tmp/test && \
  python /tmp/test/run.py; python /tmp/test/run.py && \
  cd && rm -rf /tmp/test

ENV DEFAULT_DOCKCROSS_IMAGE thewtex/cross-compiler-browser-asmjs

ENV CMAKE_TOOLCHAIN_FILE /usr/emsdk_portable/emscripten/tag-${EMSCRIPTEN_VERSION}/cmake/Modules/Platform/Emscripten.cmake
