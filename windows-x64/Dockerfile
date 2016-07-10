FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# Insert this line before "RUN apt-get update" to dynamically
# replace httpredir.debian.org with a single working domain
# in attempt to "prevent" the "Error reading from server" error.
RUN sed -i "s/httpredir.debian.org/`curl -s -D - http://httpredir.debian.org/demo/debian/ | awk '/^Link:/ { print $2 }' | sed -e 's@<http://\(.*\)/debian/>;@\1@g'`/" /etc/apt/sources.list

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
  libgdk-pixbuf2.0-dev \
  libtool-bin \
  libltdl-dev \
  libssl-dev \
  libxml-parser-perl \
  libc6-dev-i386 \
  make \
  openssl \
  p7zip-full \
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
ENV WINEARCH win64
RUN wine hostname

WORKDIR /usr/src
# mxe master 2016-04-09
RUN git clone https://github.com/mxe/mxe.git && \
  cd mxe && \
  git checkout 4accc990de7741f4d5aa37e368a732f3d47d803a
WORKDIR /usr/src/mxe
COPY settings.mk /usr/src/mxe/
RUN make -j$(nproc)

ENV PATH ${PATH}:/usr/src/mxe/usr/bin
ENV CROSS_TRIPLE x86_64-w64-mingw32.static
ENV AS=/usr/src/mxe/usr/bin/${CROSS_TRIPLE}-as \
    AR=/usr/src/mxe/usr/bin/${CROSS_TRIPLE}-ar \
    CC=/usr/src/mxe/usr/bin/${CROSS_TRIPLE}-gcc \
    CPP=/usr/src/mxe/usr/bin/${CROSS_TRIPLE}-cpp \
    CXX=/usr/src/mxe/usr/bin/${CROSS_TRIPLE}-g++ \
    LD=/usr/src/mxe/usr/bin/${CROSS_TRIPLE}-ld

ENV DEFAULT_DOCKCROSS_IMAGE thewtex/cross-compiler-windows-x64
WORKDIR /build

ENV CMAKE_TOOLCHAIN_FILE /usr/src/mxe/usr/x86_64-w64-mingw32.static/share/cmake/mxe-conf.cmake
RUN echo 'set(CMAKE_CROSSCOMPILING_EMULATOR "/usr/bin/wine")' >> ${CMAKE_TOOLCHAIN_FILE}
