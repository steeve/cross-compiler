FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# Add the cross compiler sources
RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
  dpkg --add-architecture armhf && \
  curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -

RUN apt-get update && apt-get install -y \
  crossbuild-essential-armhf \
  gfortran-arm-linux-gnueabihf \
  qemu-user \
  qemu-user-static

WORKDIR /usr/src

COPY Toolchain.cmake /usr/src/
ENV CMAKE_TOOLCHAIN_FILE /usr/src/Toolchain.cmake
