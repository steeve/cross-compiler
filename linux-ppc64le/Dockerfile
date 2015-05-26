FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# Add the cross compiler sources
RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
  dpkg --add-architecture ppc64el && \
  curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -

RUN apt-get update && apt-get install -y \
  crossbuild-essential-ppc64el \
  gfortran-powerpc64le-linux-gnu

ENV CROSS_TRIPLE powerpc64le-linux-gnu
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}

WORKDIR /usr/src

RUN apt-get update && \
  apt-get install -y libglib2.0-dev zlib1g-dev libpixman-1-dev && \
  curl -L http://wiki.qemu-project.org/download/qemu-2.3.0.tar.bz2 | tar xj && \
  cd qemu-2.3.0 && \
  ./configure --target-list=ppc64le-linux-user --prefix=/usr && \
  make -j$(nproc) && \
  make install && \
  cd .. && rm -rf qemu-2.3.0

# Note: Toolchain file support is currently in debian Experimental according to:
# https://wiki.debian.org/CrossToolchains#In_jessie_.28Debian_8.29
# We can switch to that when it becomes stable.
COPY Toolchain.cmake /usr/lib/${CROSS_TRIPLE}/
ENV CMAKE_TOOLCHAIN_FILE /usr/lib/${CROSS_TRIPLE}/Toolchain.cmake
