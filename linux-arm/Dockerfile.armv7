FROM steeve/cross-compiler:base
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

# Add the cross compiler sources
RUN echo "deb     http://toolchains.secretsauce.net unstable main" >> /etc/apt/sources.list && \
    dpkg --add-architecture armhf && \
    curl -L http://toolchains.secretsauce.net/key.gpg | apt-key add -

RUN apt-get update && apt-get -y install \
                        gcc-4.9-arm-linux-gnueabihf \
                        g++-4.9-arm-linux-gnueabihf

ENV CROSS_TRIPLE arm-linux-gnueabihf
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV PATH ${PATH}:${CROSS_ROOT}/bin
ENV LD_LIBRARY_PATH ${CROSS_ROOT}/lib:${LD_LIBRARY_PATH}

RUN cd /usr/bin && \
    ln -s ${CROSS_TRIPLE}-gcc-4.9 ${CROSS_TRIPLE}-cc && \
    ln -s ${CROSS_TRIPLE}-gcc-4.9 ${CROSS_TRIPLE}-gcc && \
    ln -s ${CROSS_TRIPLE}-g++-4.9 ${CROSS_TRIPLE}-g++ && \
    ln -s ${CROSS_TRIPLE}-g++-4.9 ${CROSS_TRIPLE}-c++
