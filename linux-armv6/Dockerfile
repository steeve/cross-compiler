FROM thewtex/cross-compiler-base
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

# Enable 32 bits binaries
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386

# Raspberry Pi is ARMv6+VFP2, Debian armhf is ARMv7+VFP3
# Since this Dockerfile is targeting linux-arm from Raspberry Pi onward,
# we're sticking with it's custom built cross-compiler with hardfp support.
# We could use Debian's armel, but we'd have softfp and loose a good deal
# of performance.
# See: https://wiki.debian.org/RaspberryPi
# We are also using the 4.7 version of the toolchain, so that glibc=2.13
ENV CROSS_TRIPLE arm-linux-gnueabihf
ENV RASPBERRYPI_TOOLS_COMMIT 9c3d7b6ac692498dd36fec2872e0b55f910baac1
RUN curl -L https://github.com/raspberrypi/tools/archive/${RASPBERRYPI_TOOLS_COMMIT}.tar.gz | tar xvz --wildcards --no-anchored "*gcc-linaro-${CROSS_TRIPLE}-raspbian*" && \
    rsync -av /usr/src/tools-${RASPBERRYPI_TOOLS_COMMIT}/arm-bcm2708/gcc-linaro-${CROSS_TRIPLE}-raspbian/ /usr/ && \
    rm -rf /usr/src/tools-${RASPBERRYPI_TOOLS_COMMIT}

COPY Toolchain.cmake /usr/${CROSS_TRIPLE}/
ENV CMAKE_TOOLCHAIN_FILE /usr/${CROSS_TRIPLE}/Toolchain.cmake
