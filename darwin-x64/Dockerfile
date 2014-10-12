FROM debian:jessie
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

RUN apt-get update && apt-get -y --force-yes install \
                        bash \
                        curl \
                        pkg-config \
                        build-essential \
                        clang-3.5 llvm-3.5-dev automake autogen \
                        libtool libxml2-dev uuid-dev libssl-dev bash patch make \
                        tar xz-utils bzip2 gzip sed cpio

ENV CROSS_TRIPLE x86_64-apple-darwin13
ENV CROSS_ROOT /clang-${CROSS_TRIPLE}
ENV MAC_SDK_VERSION 10.9
ENV PATH ${PATH}:${CROSS_ROOT}/bin
ENV LD_LIBRARY_PATH /usr/lib/llvm-3.5/lib:${CROSS_ROOT}/lib:${LD_LIBRARY_PATH}

RUN curl -L https://github.com/tpoechtrager/osxcross/archive/master.tar.gz | tar xvz
COPY MacOSX${MAC_SDK_VERSION}.sdk.tar.bz2 /osxcross-master/tarballs/

# Build the toolchain
RUN cd /osxcross-master && echo | SDK_VERSION=${MAC_SDK_VERSION} OSX_VERSION_MIN=10.6 ./build.sh
RUN mv /osxcross-master/target ${CROSS_ROOT} && \
    mkdir -p ${CROSS_ROOT}/lib && \
    rm -rf /osxcross-master
