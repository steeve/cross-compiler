FROM debian:jessie
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

RUN apt-get update && apt-get -y --force-yes install \
                        bash \
                        curl \
                        pkg-config \
                        build-essential \
                        file \
                        mingw-w64 \
                        tar xz-utils bzip2 gzip sed

ENV CROSS_TRIPLE i686-w64-mingw32
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV PATH ${PATH}:${CROSS_ROOT}/bin
ENV LD_LIBRARY_PATH ${CROSS_ROOT}/lib:${LD_LIBRARY_PATH}

RUN cd /usr/bin && \
    ln -s ${CROSS_TRIPLE}-gcc ${CROSS_TRIPLE}-cc
