#!/usr/bin/env bash

set -ex

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/utils.sh

#
# Function 'do_curl_build' and 'build_curl'
# copied from https://github.com/pypa/manylinux/tree/master/docker/build_scripts
#

CURL_ROOT=curl-7_83_1
CURL_HASH=93fb2cd4b880656b4e8589c912a9fd092750166d555166370247f09d18f5d0c0
CURL_DOWNLOAD_URL=https://curl.haxx.se/download

function do_curl_build {
    # We do this shared to avoid obnoxious linker issues where git couldn't
    # link properly. If anyone wants to make this build statically go for it.
    LIBS=-ldl CFLAGS=-Wl,--exclude-libs,ALL ./configure --with-ssl --disable-static > /dev/null
    make -j"$(nproc)" > /dev/null
    make install > /dev/null
}


function build_curl {
    local curl_fname=$1
    check_var ${curl_fname}
    local curl_sha256=$2
    check_var ${curl_sha256}
    check_var ${CURL_DOWNLOAD_URL}
    curl --connect-timeout 30 \
        --max-time 10 \
        --retry 5 \
        --retry-delay 10 \
        --retry-max-time 30 \
        -fsSLO ${CURL_DOWNLOAD_URL}/${curl_fname}.tar.gz

    check_sha256sum ${curl_fname}.tar.gz ${curl_sha256}
    tar -zxf ${curl_fname}.tar.gz
    (cd curl-*/ && do_curl_build)
    rm -rf curl-*
}

cd /usr/src
build_curl $CURL_ROOT $CURL_HASH

(cat /etc/ld.so.conf.d/usr-local.conf 2> /dev/null | grep -q "^/usr/local/lib$") ||
  echo '/usr/local/lib' >> /etc/ld.so.conf.d/usr-local.conf
ldconfig

