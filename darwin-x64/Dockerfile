FROM steeve/cross-compiler:base
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

ENV CROSS_TRIPLE x86_64-apple-darwin13
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV PATH ${PATH}:${CROSS_ROOT}/bin
ENV LD_LIBRARY_PATH /usr/lib/llvm-3.5/lib:${CROSS_ROOT}/lib
ENV MAC_SDK_VERSION 10.9

RUN curl -L https://github.com/tpoechtrager/osxcross/archive/master.tar.gz | tar xvz
COPY MacOSX${MAC_SDK_VERSION}.sdk.tar.bz2 /osxcross-master/tarballs/

# Build the toolchain
WORKDIR /osxcross-master

RUN ./tools/get_dependencies.sh && \
    echo | SDK_VERSION=${MAC_SDK_VERSION} OSX_VERSION_MIN=10.6 ./build.sh && \
    mv /osxcross-master/target ${CROSS_ROOT} && \
    mkdir -p ${CROSS_ROOT}/lib && \
    rm -rf /osxcross-master

WORKDIR /
