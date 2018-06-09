#!/bin/bash

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

cd /tmp

curl -# -LO https://bootstrap.pypa.io/get-pip.py
${PYTHON} get-pip.py --ignore-installed
rm get-pip.py

${PYTHON} -m pip install --ignore-installed conan
