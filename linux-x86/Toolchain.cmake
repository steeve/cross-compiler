set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR i686)

# Setting these is not needed because the -m32 flag is already
# associated with the ${cross_triple}-gcc wrapper script.
#set(CMAKE_CXX_COMPILER_ARG1 "-m32")
#set(CMAKE_C_COMPILER_ARG1 "-m32")

set(cross_triple "i686-linux-gnu")

set(CMAKE_C_COMPILER $ENV{CC})
set(CMAKE_CXX_COMPILER $ENV{CXX})
set(CMAKE_Fortran_COMPILER $ENV{FC})
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})

# Discard path returned by pkg-config and associated with HINTS in module
# like FindOpenSSL.
set(CMAKE_IGNORE_PATH /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/lib/)

set(CMAKE_CROSSCOMPILING_EMULATOR /usr/${cross_triple}/bin/${cross_triple}-noop)
