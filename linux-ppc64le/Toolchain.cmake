set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)

set(cross_triple "powerpc64le-linux-gnu")

set(CMAKE_C_COMPILER /usr/bin/${cross_triple}-cc)
set(CMAKE_CXX_COMPILER /usr/bin/${cross_triple}-c++)
set(CMAKE_Fortran_COMPILER /usr/bin/${cross_triple}-gfortran)

set(CMAKE_FIND_ROOT_PATH /usr/${cross_triple})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_CROSSCOMPILING_EMULATOR /usr/bin/qemu-ppc64le)
