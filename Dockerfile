FROM debian:jessie
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

RUN apt-get update && apt-get -y install \
  automake \
  autogen \
  bash \
  build-essential \
  bzip2 \
  curl \
  file \
  gzip \
  make \
  pkg-config \
  rsync \
  sed \
  tar \
  vim \
  wget \
  xz-utils
