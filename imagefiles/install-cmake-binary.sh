#!/usr/bin/env bash

set -ex
set -o pipefail

ARCH="x86_64"

while [ $# -gt 0 ]; do
  case "$1" in
    -32)
      ARCH="x86"
      ;;
    *)
      echo "Usage: Usage: ${0##*/} [-32]"
      exit 1
      ;;
  esac
  shift
done

if ! command -v curl &> /dev/null; then
	echo >&2 'error: "curl" not found!'
	exit 1
fi

if ! command -v tar &> /dev/null; then
	echo >&2 'error: "tar" not found!'
	exit 1
fi

if [[ "${CMAKE_VERSION}" == "" ]]; then
  echo >&2 'error: CMAKE_VERSION env. variable must be set to a non-empty value'
  exit 1
fi

cd /usr/src

#Switch to newer version of CMake
#USER=dockbuild #Original user, change it when changed it when there will be a new update of CMake (3.17.1 on June 27, 2021)

USER=bensuperpc

OS=Centos7

CMAKE_ROOT=cmake-${CMAKE_VERSION}-${OS}-${ARCH}
url=https://github.com/${USER}/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_ROOT}.tar.gz
url_checksum=https://github.com/${USER}/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_ROOT}.tar.gz.sha256

echo "Downloading $url"
curl -# -LO $url

echo "Downloading $url_checksum"
curl -# -LO $url_checksum

#Checksum package
sha256sum -c ${CMAKE_ROOT}.tar.gz.sha256

tar -xzvf ${CMAKE_ROOT}.tar.gz
rm -f ${CMAKE_ROOT}.tar.gz

cd ${CMAKE_ROOT}

rm -rf doc man
rm -rf bin/cmake-gui

find . -type f -exec install -D "{}" "/usr/{}" \;
