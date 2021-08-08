#!/usr/bin/env bash
set -x
set -e
set -o pipefail

ROOT=${PWD}

REPO_URL="https://github.com/buildroot/buildroot.git"

git clone "$REPO_URL" --recurse-submodules --remote-submodules --depth=1 --branch=2021.08-rc1
cd buildroot
cp /dockcross/buildroot.config .config
make
