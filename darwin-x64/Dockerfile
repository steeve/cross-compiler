FROM steeve/cross-compiler:base
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

ENV CROSS_TRIPLE x86_64-apple-darwin14
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV PATH ${PATH}:${CROSS_ROOT}/bin
ENV LD_LIBRARY_PATH /usr/lib/llvm-3.4/lib:${CROSS_ROOT}/lib
ENV MAC_SDK_VERSION 10.10

RUN echo "deb http://llvm.org/apt/wheezy/ llvm-toolchain-wheezy-3.4-binaries main" >> /etc/apt/sources.list && \
    curl http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add - && \
    apt-get update

RUN apt-get update && \
    apt-get install -y --force-yes clang-3.4 llvm-3.4-dev automake autogen \
                                   libtool libxml2-dev uuid-dev libssl-dev bash \
                                   patch make tar xz-utils bzip2 gzip sed cpio

RUN curl -L https://github.com/tpoechtrager/osxcross/archive/master.tar.gz | tar xvz && \
    cd /osxcross-master/ && \
    curl -L -o tarballs/MacOSX${MAC_SDK_VERSION}.sdk.tar.xz https://www.dropbox.com/s/yfbesd249w10lpc/MacOSX${MAC_SDK_VERSION}.sdk.tar.xz && \
    echo | SDK_VERSION=${MAC_SDK_VERSION} OSX_VERSION_MIN=10.6 ./build.sh && \
    mv /osxcross-master/target ${CROSS_ROOT} && \
    mkdir -p ${CROSS_ROOT}/lib && \
    rm -rf /osxcross-master
