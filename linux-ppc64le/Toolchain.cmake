set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR ppc64le)

set(cross_triple "powerpc64le-linux-gnu")

set(CMAKE_C_COMPILER $ENV{CC})
set(CMAKE_CXX_COMPILER $ENV{CXX})
set(CMAKE_Fortran_COMPILER $ENV{FC})

# Discard path returned by pkg-config and associated with HINTS in module
# like FindOpenSSL.
set(CMAKE_IGNORE_PATH /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/lib/)

set(CMAKE_CROSSCOMPILING_EMULATOR /usr/bin/qemu-ppc64le)
