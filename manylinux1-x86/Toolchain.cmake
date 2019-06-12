set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_CROSSCOMPILING FALSE)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR i686)

set(MANYLINUX1 TRUE)

set(CMAKE_C_COMPILER /opt/rh/devtoolset-2/root/usr/bin/gcc)
set(CMAKE_CXX_COMPILER /opt/rh/devtoolset-2/root/usr/bin/g++)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_Fortran_COMPILER /opt/rh/devtoolset-2/root/usr/bin/gfortran)

# Discard path returned by pkg-config and associated with HINTS in module
# like FindOpenSSL.
set(CMAKE_IGNORE_PATH /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/lib/)
