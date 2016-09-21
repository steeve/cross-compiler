#!/bin/sh

# Always pass the CMAKE_TOOLCHAIN_FILE variable to CMake when inside a
# dockcross environment -- the CMAKE_TOOLCHAIN_FILE environmental variable is
# always set in this context
#
# Passing of the option can be disabled setting environment variable
# DOCKCROSS_PASS_CMAKE_TOOLCHAIN_FILE to 0

if [ "${DOCKCROSS_PASS_CMAKE_TOOLCHAIN_FILE}" == "0" ];then
  exec /usr/bin/cmake "$@"
else
  exec /usr/bin/cmake -DCMAKE_TOOLCHAIN_FILE:FILEPATH=${CMAKE_TOOLCHAIN_FILE} "$@"
fi
