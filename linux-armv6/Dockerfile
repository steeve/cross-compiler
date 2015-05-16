FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# Enable 32 bits binaries
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386

# The cross-compiling emulator
RUN apt-get update && apt-get install -y \
  qemu-user \
  qemu-user-static

ENV CROSS_TRIPLE arm-linux-gnueabihf
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}

# Raspberry Pi is ARMv6+VFP2, Debian armhf is ARMv7+VFP3
# Since this Dockerfile is targeting linux-arm from Raspberry Pi onward,
# we're sticking with it's custom built cross-compiler with hardfp support.
# We could use Debian's armel, but we'd have softfp and loose a good deal
# of performance.
# See: https://wiki.debian.org/RaspberryPi
# We are also using the 4.7 version of the toolchain, so that glibc=2.13
ENV RASPBERRYPI_TOOLS_COMMIT 9c3d7b6ac692498dd36fec2872e0b55f910baac1
RUN curl -L https://github.com/raspberrypi/tools/archive/${RASPBERRYPI_TOOLS_COMMIT}.tar.gz | tar xvz --wildcards --no-anchored "*gcc-linaro-${CROSS_TRIPLE}-raspbian*" && \
    rsync -av /usr/src/tools-${RASPBERRYPI_TOOLS_COMMIT}/arm-bcm2708/gcc-linaro-${CROSS_TRIPLE}-raspbian/ /usr/ && \
    rm -rf /usr/src/tools-${RASPBERRYPI_TOOLS_COMMIT}
# Allow dynamically linked executables to run with qemu-arm
ENV QEMU_LD_PREFIX /${CROSS_ROOT}/libc
ENV QEMU_SET_ENV "LD_LIBRARY_PATH=/${CROSS_ROOT}/lib:/${CROSS_ROOT}/libc/lib/${CROSS_TRIPLE}/"

COPY Toolchain.cmake /${CROSS_ROOT}/
ENV CMAKE_TOOLCHAIN_FILE /${CROSS_ROOT}/Toolchain.cmake
