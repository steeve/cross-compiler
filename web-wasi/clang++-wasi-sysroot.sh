#!/usr/bin/env sh

exec ${WASI_SDK_PATH}/bin/clang++ --sysroot=${WASI_SYSROOT} "$@"
