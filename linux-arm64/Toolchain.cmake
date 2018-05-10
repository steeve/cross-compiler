
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(cross_triple "aarch64-unknown-linux-gnueabi")

set(CMAKE_C_COMPILER /usr/bin/aarch64-unknown-linux-gnueabi/bin/${cross_triple}-cc)
set(CMAKE_CXX_COMPILER /usr/bin/aarch64-unknown-linux-gnueabi/bin/${cross_triple}-c++)
set(CMAKE_Fortran_COMPILER /usr/bin/aarch64-unknown-linux-gnueabi/bin/${cross_triple}-gfortran)

set(CMAKE_FIND_ROOT_PATH /usr/bin/aarch64-unknown-linux-gnueabi)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_SYSROOT /usr/bin/aarch64-unknown-linux-gnueabi/aarch64-unknown-linux-gnueabi/sysroot)

set(CMAKE_CXX_FLAGS "-I /usr/bin/aarch64-unknown-linux-gnueabi/include")
set(ADDITIONAL_COMPILER_FLAGS "-L /usr/lib/aarch64-linux-gnu -Wl,-rpath-link,/usr/lib/aarch64-linux-gnu -Wl,-rpath-link,/lib/aarch64-linux-gnu")

set(CMAKE_CROSSCOMPILING_EMULATOR /usr/bin/qemu-aarch64)
