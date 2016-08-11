FROM debian:jessie
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# Insert this line before "RUN apt-get update" to dynamically
# replace httpredir.debian.org with a single working domain
# in attempt to "prevent" the "Error reading from server" error.
RUN apt-get update && apt-get install -y curl && \
  sed -i "s/httpredir.debian.org/`curl -s -D - http://httpredir.debian.org/demo/debian/ | awk '/^Link:/ { print $2 }' | sed -e 's@<http://\(.*\)/debian/>;@\1@g'`/" /etc/apt/sources.list

RUN apt-get update && apt-get -y install \
  automake \
  autogen \
  bash \
  build-essential \
  bzip2 \
  ca-certificates \
  curl \
  file \
  git \
  gzip \
  libcurl4-openssl-dev \
  libssl-dev \
  make \
  ncurses-dev \
  pkg-config \
  libtool \
  python \
  rsync \
  sed \
  bison \
  flex \
  tar \
  vim \
  wget \
  runit \
  xz-utils && \
  apt-get -y clean

WORKDIR /usr/share
RUN git clone https://github.com/nojhan/liquidprompt.git && \
  cd liquidprompt && \
  git checkout v_1.11
COPY imagefiles/.bashrc /root/

# Build and install CMake from source.
WORKDIR /usr/src
RUN git clone git://cmake.org/cmake.git CMake && \
   cd CMake && \
   git checkout v3.6.1 && \
   cd .. && mkdir CMake-build && cd CMake-build && \
   /usr/src/CMake/bootstrap \
     --parallel=$(nproc) \
     --prefix=/usr && \
   make -j$(nproc) && \
   ./bin/cmake -DCMAKE_USE_SYSTEM_CURL:BOOL=ON \
     -DCMAKE_BUILD_TYPE:STRING=Release \
     -DCMAKE_USE_OPENSSL:BOOL=ON . && \
   make install && \
   cd .. && \
   rm -rf CMake*
# Wrappers that point to CMAKE_TOOLCHAIN_FILE

# Build and install Ninja from source
RUN git clone https://github.com/martine/ninja.git && \
   cd ninja && \
   git checkout v1.7.1 && \
   python ./configure.py --bootstrap && \
   ./ninja && \
   cp ./ninja /usr/bin/ && \
   cd .. && rm -rf ninja
COPY imagefiles/cmake.sh /usr/local/bin/cmake
COPY imagefiles/ccmake.sh /usr/local/bin/ccmake

RUN echo "root:root" | chpasswd
WORKDIR /work
ENTRYPOINT ["/dockcross/entrypoint.sh"]

COPY imagefiles/entrypoint.sh imagefiles/dockcross /dockcross/
