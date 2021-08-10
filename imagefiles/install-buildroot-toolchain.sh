#!/usr/bin/env bash
set -x
set -e
set -o pipefail

ROOT=${PWD}

usage() { echo "Usage: $0 -c <config-path> -v <version>" 1>&2; exit 1; }

REPO_URL="https://github.com/buildroot/buildroot.git"

CONFIG_PATH=""
REV="2021.08-rc1"
while getopts "c:v:" o; do
  case "${o}" in
  c)
    CONFIG_PATH=$(readlink -f ${OPTARG})
    ;;
  v)
    REV=${OPTARG}
    ;;
  *)
    usage
    ;;
  esac
done
shift $((OPTIND-1))

if [ -z ${CONFIG_PATH} ] || [ ! -f ${CONFIG_PATH} ]; then
  echo "ERROR: Missing config path (-c)."
  usage
fi

if [ -z ${REV} ]; then
  echo "WARNING: No version selected, use default version: $REV (-v)."
fi


git clone "$REPO_URL" --recurse-submodules --remote-submodules #--branch="$REV"
cd buildroot
git checkout "$REV"
cp "$CONFIG_PATH" .config
make
