#!/usr/bin/env bash

#
# Configure, build and install ninja
#
# Usage:
#
#  build-and-install-ninja.sh [-python /path/to/bin/python]

set -e
set -o pipefail

PYTHON=python
while [ $# -gt 0 ]; do
  case "$1" in
    -python)
      PYTHON=$2
      shift
      ;;
    *)
      echo "Usage: Usage: ${0##*/} [-python /path/to/bin/python]"
      exit 1
      ;;
  esac
  shift
done

if [[ -z "${NINJA_VERSION}" ]]; then
  echo >&2 'error: NINJA_VERSION env. variable must be set to a non-empty value'
  exit 1
fi

# Download
url="https://github.com/ninja-build/ninja/archive/${NINJA_VERSION}.tar.gz"

curl --connect-timeout 30 \
    --max-time 10 \
    --retry 5 \
    --retry-delay 10 \
    --retry-max-time 30 \
    -# -o ninja.tar.gz -LO "v$url"

mkdir ninja
tar -xzvf ./ninja.tar.gz --strip-components=1 -C ./ninja

# Configure, build and install
pushd ./ninja
echo "Configuring ninja using [$PYTHON]"
$PYTHON ./configure.py --bootstrap && ./ninja
cp ./ninja /usr/bin/
popd

# Clean
rm -rf ./ninja*

