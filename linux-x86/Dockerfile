FROM steeve/cross-compiler:base
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

RUN apt-get update && apt-get -y install \
                        gcc-multilib \
                        g++-multilib

ENV CROSS_TRIPLE i686-linux-gnu
ENV CROSS_ROOT /usr/i686-linux-gnu
ENV PATH ${PATH}:${CROSS_ROOT}/bin
ENV LD_LIBRARY_PATH ${CROSS_ROOT}/lib:${LD_LIBRARY_PATH}

COPY ${CROSS_TRIPLE}.sh /usr/bin/${CROSS_TRIPLE}.sh
RUN mkdir -p ${CROSS_ROOT} && \
    cd /usr/bin && \
    chmod +x ${CROSS_TRIPLE}.sh && \
    ln -s x86_64-linux-gnu-gcc x86_64-linux-gnu-cc && \
    ln -s x86_64-linux-gnu-g++ x86_64-linux-gnu-c++ && \
    ln -s ${CROSS_TRIPLE}.sh ${CROSS_TRIPLE}-gcc && \
    ln -s ${CROSS_TRIPLE}.sh ${CROSS_TRIPLE}-cc && \
    ln -s ${CROSS_TRIPLE}.sh ${CROSS_TRIPLE}-g++ && \
    ln -s ${CROSS_TRIPLE}.sh ${CROSS_TRIPLE}-c++ && \
    for i in strip objdump; do \
        ln -s ${i} ${CROSS_TRIPLE}-${i} ; \
    done && \
    for i in ranlib nm ar; do \
        ln -s x86_64-linux-gnu-gcc-${i}-4.7 ${CROSS_TRIPLE}-${i} ; \
    done
