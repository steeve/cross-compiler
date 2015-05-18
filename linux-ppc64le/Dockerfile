FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# Add the cross compiler sources
RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
  dpkg --add-architecture ppc64el && \
  curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -

RUN apt-get update && apt-get install -y \
  crossbuild-essential-ppc64el \
  gfortran-powerpc64le-linux-gnu \
  qemu-user \
  qemu-user-static

WORKDIR /usr/src

# Note: Toolchain file support is currently in debian Experimental according to:
# https://wiki.debian.org/CrossToolchains#In_jessie_.28Debian_8.29
# We can switch to that when it becomes stable.
COPY Toolchain.cmake /usr/lib/powerpc64le-linux-gnu/
ENV CMAKE_TOOLCHAIN_FILE /usr/lib/powerpc64le-linux-gnu/Toolchain.cmake
