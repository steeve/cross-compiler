FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# WINE is used as an emulator for try_run and tests with CMake.
# Other dependencies are from the listed MXE requirements:
#   http://mxe.cc/#requirements
# 'cmake' is omitted because it is installed from source in the base image
RUN apt-get update && apt-get -y install \
  autoconf \
  automake \
  autopoint \
  bash \
  bison \
  bzip2 \
  flex \
  gettext \
  git \
  g++ \
  g++-multilib \
  gperf \
  intltool \
  libffi-dev \
  libtool-bin \
  libltdl-dev \
  libssl-dev \
  libxml-parser-perl \
  libc6-dev-i386 \
  make \
  openssl \
  patch \
  perl \
  pkg-config \
  python \
  ruby \
  scons \
  sed \
  unzip \
  wget \
  wine \
  xz-utils
# Set up wine
RUN dpkg --add-architecture i386 && \
  apt-get update && \
  apt-get install -y wine32
ENV WINEARCH win32
RUN wine hostname

WORKDIR /usr/src
# mxe master 2015-03-12, prior to mingw-w64 update, based on GCC 4
RUN git clone https://github.com/mxe/mxe.git && \
  cd mxe && \
  git checkout 149afe17a43c50c234dcadeb4a69e61e272a747a
WORKDIR /usr/src/mxe
COPY settings.mk /usr/src/mxe/
RUN make -j$(nproc)

ENV PATH ${PATH}:/usr/src/mxe/usr/bin
ENV CMAKE_TOOLCHAIN_FILE /usr/src/mxe/usr/i686-w64-mingw32.static/share/cmake/mxe-conf.cmake
RUN echo 'set(CMAKE_CROSSCOMPILING_EMULATOR "/usr/bin/wine")' >> ${CMAKE_TOOLCHAIN_FILE}

WORKDIR /usr/src
