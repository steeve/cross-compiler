#!/usr/bin/env bash

set -ex

if ! command -v git &> /dev/null; then
	echo >&2 'error: "git" not found!'
	exit 1
fi

if [[ "${FLATCC_VERSION}" == "" ]]; then
  echo >&2 'error: FLATCC_VERSION env. variable must be set to a non-empty value'
  exit 1
fi

cd /usr/src

git clone https://github.com/dvidelabs/flatcc.git flatcc -b $FLATCC_VERSION --depth 1

cd flatcc

cmake -DFLATCC_INSTALL=on && make install > /dev/null

./scripts/cleanall.sh
