FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

RUN dpkg --add-architecture i386 && \
  apt-get update && apt-get -y install \
    gcc-multilib \
    g++-multilib

ENV CROSS_TRIPLE i686-linux-gnu
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV PATH ${PATH}:${CROSS_ROOT}/bin
RUN mkdir -p ${CROSS_ROOT}/bin
COPY ${CROSS_TRIPLE}.sh ${CROSS_ROOT}/bin/${CROSS_TRIPLE}.sh
RUN cd ${CROSS_ROOT}/bin && \
  chmod +x ${CROSS_TRIPLE}.sh && \
  ln -s /usr/bin/x86_64-linux-gnu-gcc && \
  ln -s /usr/bin/x86_64-linux-gnu-g++ && \
  ln -s ${CROSS_TRIPLE}.sh ${CROSS_TRIPLE}-gcc && \
  ln -s ${CROSS_TRIPLE}.sh ${CROSS_TRIPLE}-g++
ENV CC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gcc \
    CXX=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-g++
