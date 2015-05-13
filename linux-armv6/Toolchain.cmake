set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)

set(cross_triple "arm-linux-gnueabihf")

set(CMAKE_C_COMPILER /usr/bin/${cross_triple}-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/${cross_triple}-g++)
set(CMAKE_Fortran_COMPILER /usr/bin/${cross_triple}-gfortran)

set(CMAKE_FIND_ROOT_PATH /usr/${cross_triple})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_CROSSCOMPILING_EMULATOR /usr/bin/qemu-arm)
