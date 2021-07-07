
# dockcross


Cross compiling toolchains in Docker images.

[![image](https://github.com/dockcross/dockcross/workflows/Dockcross%20CI/badge.svg)](https://github.com/dockcross/dockcross/actions?query=branch%3Amaster)

## Features

-   Pre-built and configured toolchains for cross compiling.
-   Most images also contain an emulator for the target system.
-   Clean separation of build tools, source code, and build artifacts.
-   Commands in the container are run as the calling user, so that any
    created files have the expected ownership, (i.e. not root).
-   Make variables ([CC]{.title-ref}, [LD]{.title-ref} etc) are set to
    point to the appropriate tools in the container.
-   Recent [CMake](https://cmake.org) and ninja are precompiled.
-   [Conan.io](https://www.conan.io) can be used as a package manager.
-   Toolchain files configured for CMake.
-   Current directory is mounted as the container\'s workdir, `/work`.
-   Works with the [Docker for
    Mac](https://docs.docker.com/docker-for-mac/) and [Docker for
    Windows](https://docs.docker.com/docker-for-windows/).
-   Support using alternative container executor by setting
    [OCI_EXE]{.title-ref} environment variable. By default, it searches
    for [docker]{.title-ref} and
    \[[podman]{.title-ref}\](<https://podman.io/>) executable.

## Examples

1.  `dockcross make`: Build the *Makefile* in the current directory.
2.  `dockcross cmake -Bbuild -H. -GNinja`: Run CMake with a build
    directory `./build` for a *CMakeLists.txt* file in the current
    directory and generate `ninja` build configuration files.
3.  `dockcross ninja -Cbuild`: Run ninja in the `./build` directory.
4.  `dockcross bash -c '$CC test/C/hello.c -o hello'`: Build the
    *hello.c* file with the compiler identified with the `CC`
    environmental variable in the build environment.
5.  `dockcross bash`: Run an interactive shell in the build environment.

Note that commands are executed verbatim. If any shell processing for
environment variable expansion or redirection is required, please use
[bash -c \'command args\...\']{.title-ref}.

## Installation

This image does not need to be run manually. Instead, there is a helper
script to execute build commands on source code existing on the local
host filesystem. This script is bundled with the image.

To install the helper script, run one of the images with no arguments,
and redirect the output to a file:

    docker run --rm CROSS_COMPILER_IMAGE_NAME > ./dockcross
    chmod +x ./dockcross
    mv ./dockcross ~/bin/

Where [CROSS_COMPILER_IMAGE_NAME]{.title-ref} is the name of the
cross-compiler toolchain Docker instance, e.g.
[dockcross/linux-armv7]{.title-ref}.

Only 64-bit x86_64 images are provided; a 64-bit x86_64 host system is
required.

## Usage

For the impatient, here\'s how to compile a hello world for armv7:

    cd ~/src/dockcross
    docker run --rm dockcross/linux-armv7 > ./dockcross-linux-armv7
    chmod +x ./dockcross-linux-armv7
    ./dockcross-linux-armv7 bash -c '$CC test/C/hello.c -o hello_arm'

Note how invoking any toolchain command (make, gcc, etc.) is just a
matter of prepending the **dockcross** script on the commandline:

    ./dockcross-linux-armv7 [command] [args...]

The dockcross script will execute the given command-line inside the
container, along with all arguments passed after the command. Commands
that evaluate environmental variables in the image, like
[\$CC]{.title-ref} above, should be executed in [bash -c].
The present working directory is mounted within the image, which can be
used to make source code available in the Docker container.

## Cross compilers

### dockcross/base

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/base/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/base/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/base) ![Docker Stars](https://img.shields.io/docker/stars/dockcross/base)

Base image for other toolchain images. From Debian Jessie with GCC,
make, autotools, CMake, Ninja, Git, and Python.

### dockcross/android-arm

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/android-arm/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/android-arm/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/android-arm)

The Android NDK standalone toolchain for the arm architecture.

### dockcross/android-arm64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/android-arm64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/android-arm64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/android-arm64)

The Android NDK standalone toolchain for the arm64 architecture.

### dockcross/android-x86

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/android-x86/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/android-x86/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/android-x86)

The Android NDK standalone toolchain for the x86 architecture.

### dockcross/android-x86_64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/android-x86_64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/android-x86_64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/android-x86_64)

The Android NDK standalone toolchain for the x86_64 architecture.

### dockcross/linux-arm64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-arm64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-arm64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-arm64)

Cross compiler for the 64-bit ARM platform on Linux, also known as
AArch64.

### dockcross/linux-arm64-musl

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-arm64-musl/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-arm64-musl/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-arm64-musl)

Cross compiler for the 64-bit ARM platform on Linux (also known as
AArch64), using [musl](https://www.musl-libc.org/) as base \"libc\".

### dockcross/linux-armv5

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-armv5/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-armv5/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-armv5)

Linux armv5 cross compiler toolchain for legacy devices like the
Parrot AR Drone.

### dockcross/linux-armv5-musl

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-armv5-musl/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-armv5-musl/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-armv5-musl)

Linux armv5 cross compiler toolchain using
[musl](https://www.musl-libc.org/) as base \"libc\".

### dockcross/linux-armv6

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-armv6/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-armv6/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-armv6)

Linux ARMv6 cross compiler toolchain for the Raspberry Pi, etc.

### dockcross/linux-armv6-musl

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-armv6-musl/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-armv6-musl/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-armv6-musl)

Linux ARMv6 cross compiler toolchain for the Raspberry Pi, etc,
using [musl](https://www.musl-libc.org/) as base \"libc\".

### dockcross/linux-armv7

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-armv7/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-armv7/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-armv7)

Generic Linux armv7 cross compiler toolchain.

### dockcross/linux-armv7a

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-armv7a/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-armv7a/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-armv7a)

Toolchain configured for ARMv7-A used in Beaglebone Black single
board PC with TI SoC AM3358 on board, Cortex-A8.

### dockcross/linux-armv7l-musl

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-armv7l-musl/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-armv7l-musl/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-armv7l-musl)

Toolchain configured for ARMv7-L, using
[musl](https://www.musl-libc.org/) as base \"libc\".

### dockcross/linux-mipsel

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-mipsel/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-mipsel/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-mipsel)

Linux mipsel cross compiler toolchain for little endian MIPS GNU
systems.

### dockcross/linux-mips

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-mips/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-mips/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-mips)

Linux mips cross compiler toolchain for big endian 32-bit hard float
MIPS GNU systems.

### dockcross/linux-s390x

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-s390x/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-s390x/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-s390x)

Linux s390x cross compiler toolchain for S390X GNU systems.

### dockcross/linux-riscv64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-riscv64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-riscv64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-riscv64)

Linux risc-v 64bit cross compiler toolchain for risc-v 64bit GNU systems.

### dockcross/linux-riscv32

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-riscv32/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-riscv32/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-riscv32)

Linux risc-v 32bit cross compiler toolchain for risc-v 32bit GNU systems.

### dockcross/linux-m68k-uclibc

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-m68k-uclibc/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-m68k-uclibc/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-m68k-uclibc)

Linux m68k cross compiler toolchain for m68k GNU systems (http://www.mac.linux-m68k.org/ and http://www.linux-m68k.org/).

### dockcross/linux-ppc64le

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-ppc64le/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-ppc64le/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-ppc64le)

Linux PowerPC 64 little endian cross compiler toolchain for the
POWER8, etc. Important: Due to Issue #430, automatic build of newer
images has been disabled.

### dockcross/linux-x64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-x64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-x64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-x64)

Linux x86_64 / amd64 compiler. Since the Docker image is natively
x86_64, this is not actually a cross compiler.

### dockcross/linux-x64-clang

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-x64-clang/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-x64-clang/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-x64-clang)

Linux clang x86_64 / amd64 compiler. Since the Docker image is
natively x86_64, this is not actually a cross compiler.

### dockcross/linux-x86

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/linux-x86/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/linux-x86/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/linux-x86)

Linux i686 cross compiler.

### dockcross/manylinux2014-x64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/manylinux2014-x64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/manylinux2014-x64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/manylinux2014-x64)

Docker [manylinux2014](https://github.com/pypa/manylinux) image for
building Linux x86_64 / amd64 [Python wheel
packages](http://pythonwheels.com/). It includes Python 3.5, 3.6,
3.7, 3.8, and 3.9. Also has support for the dockcross script, and it
has installations of CMake, Ninja, and
[scikit-build](http://scikit-build.org). For CMake, it sets
[MANYLINUX2014]{.title-ref} to \"TRUE\" in the toolchain.

### dockcross/manylinux2014-x86

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/manylinux2014-x86/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/manylinux2014-x86/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/manylinux2014-x86)

Docker [manylinux2014](https://github.com/pypa/manylinux) image for
building Linux i686 [Python wheel
packages](http://pythonwheels.com/). It includes Python 3.5, 3.6,
3.7, 3.8, and 3.9. Also has support for the dockcross script, and it
has installations of CMake, Ninja, and
[scikit-build](http://scikit-build.org). For CMake, it sets
[MANYLINUX2014]{.title-ref} to \"TRUE\" in the toolchain.

### dockcross/manylinux2014-aarch64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/manylinux2014-aarch64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/manylinux2014-aarch64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/manylinux2014-aarch64)

Docker [manylinux2014](https://github.com/pypa/manylinux) image for
building Linux aarch64 / arm64 [Python wheel
packages](http://pythonwheels.com/). It includes Python 3.5, 3.6,
3.7, 3.8, and 3.9. Also has support for the dockcross script, and it
has installations of CMake, Ninja, and
[scikit-build](http://scikit-build.org). For CMake, it sets
[MANYLINUX2014]{.title-ref} to \"TRUE\" in the toolchain.

### dockcross/manylinux2010-x64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/manylinux2010-x64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/manylinux2010-x64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/manylinux2010-x64)

Docker [manylinux2010](https://github.com/pypa/manylinux)
image for building Linux x86_64 / amd64 [Python wheel
packages](http://pythonwheels.com/). It includes Python 2.7, 3.4,
3.5, 3.6, 3.7 and 3.8. Also has support for the dockcross script,
and it has installations of CMake, Ninja, and
[scikit-build](http://scikit-build.org). For CMake, it sets
[MANYLINUX2010]{.title-ref} to \"TRUE\" in the toolchain.

### dockcross/manylinux2010-x86

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/manylinux2010-x86/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/manylinux2010-x86/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/manylinux2010-x86)

Docker [manylinux2010](https://github.com/pypa/manylinux) image for
building Linux i686 [Python wheel
packages](http://pythonwheels.com/). It includes Python 2.7, 3.4,
3.5, 3.6, 3.7 and 3.8. Also has support for the dockcross script,
and it has installations of CMake, Ninja, and
[scikit-build](http://scikit-build.org). For CMake, it sets
[MANYLINUX2010]{.title-ref} to \"TRUE\" in the toolchain.

### dockcross/manylinux1-x64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/manylinux1-x64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/manylinux1-x64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/manylinux1-x64)

Docker [manylinux1](https://github.com/pypa/manylinux/tree/manylinux1)
image for building Linux x86_64 / amd64 [Python wheel
packages](http://pythonwheels.com/). It includes Python 2.7, 3.4,
3.5, 3.6, 3.7 and 3.8. Also has support for the dockcross script,
and it has installations of CMake, Ninja, and
[scikit-build](http://scikit-build.org). For CMake, it sets
[MANYLINUX1]{.title-ref} to \"TRUE\" in the toolchain.

### dockcross/manylinux1-x86

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/manylinux1-x86/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/manylinux1-x86/latest)  ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/manylinux1-x86)

Docker [manylinux1](https://github.com/pypa/manylinux/tree/manylinux1)
image for building Linux i686 [Python wheel
packages](http://pythonwheels.com/). It includes Python 2.7, 3.4,
3.5, 3.6, 3.7 and 3.8. Also has support for the dockcross script,
and it has installations of CMake, Ninja, and
[scikit-build](http://scikit-build.org). For CMake, it sets
[MANYLINUX1]{.title-ref} to \"TRUE\" in the toolchain.

### dockcross/web-wasm

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/web-wasm/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/web-wasm/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/web-wasm)

The Emscripten WebAssembly/asm.js/JavaScript cross compiler.

### dockcross/windows-static-x64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/windows-static-x64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/windows-static-x64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/windows-static-x64)

64-bit Windows cross-compiler based on [MXE/MinGW-w64](https://mxe.cc/) with win32 threads and static
linking.

### dockcross/windows-static-x64-posix

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/windows-static-x64-posix/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/windows-static-x64-posix/latest)  ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/windows-static-x64-posix)

64-bit Windows cross-compiler based on [MXE/MinGW-w64](https://mxe.cc/) with posix threads and static
linking.

### dockcross/windows-static-x86

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/windows-static-x86/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/windows-static-x86/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/windows-static-x86)

32-bit Windows cross-compiler based on [MXE/MinGW-w64](https://mxe.cc/) with win32 threads and static linking.

### dockcross/windows-shared-x64

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/windows-shared-x64/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/windows-shared-x64/latest) ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/windows-shared-x64)

64-bit Windows cross-compiler based on [MXE/MinGW-w64](https://mxe.cc/) with win32 threads and dynamic linking.

### dockcross/windows-shared-x64-posix

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/windows-shared-x64-posix/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/windows-shared-x64-posix/latest)  ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/windows-shared-x64-posix)

64-bit Windows cross-compiler based on [MXE/MinGW-w64](https://mxe.cc/) with posix threads and dynamic linking.

### dockcross/windows-shared-x86

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dockcross/windows-shared-x86/latest) ![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dockcross/windows-shared-x86/latest)   ![Docker Pulls](https://img.shields.io/docker/pulls/dockcross/windows-shared-x86)

32-bit Windows cross-compiler based on [MXE/MinGW-w64](https://mxe.cc/) with win32 threads and dynamic linking.

## Articles

-   [dockcross: C++ Write Once, Run
    Anywhere](https://nbviewer.jupyter.org/format/slides/github/dockcross/cxx-write-once-run-anywhere/blob/master/dockcross_CXX_Write_Once_Run_Anywhere.ipynb#/)
-   [Cross-compiling binaries for multiple architectures with
    Docker](https://web.archive.org/web/20170912153531/http://blogs.nopcode.org/brainstorm/2016/07/26/cross-compiling-with-docker)

## Built-in update commands

A special update command can be executed that will update the source
cross-compiler Docker image or the dockcross script itself.

-   `dockcross [--] command [args...]`: Forces a command to run inside
    the container (in case of a name clash with a built-in command), use
    `--` before the command.
-   `dockcross update-image`: Fetch the latest version of the docker
    image.
-   `dockcross update-script`: Update the installed dockcross script
    with the one bundled in the image.
-   `dockcross update`: Update both the docker image, and the dockcross
    script.

## Download all images

To easily download all images, the convenience target `display_images`
could be used:

    curl https://raw.githubusercontent.com/dockcross/dockcross/master/Makefile -o dockcross-Makefile
    for image in $(make -f dockcross-Makefile display_images); do
      echo "Pulling dockcross/$image"
      docker pull dockcross/$image
    done

## Install all dockcross scripts

To automatically install in `~/bin` the dockcross scripts for each
images already downloaded, the convenience target `display_images` could
be used:

    curl https://raw.githubusercontent.com/dockcross/dockcross/master/Makefile -o dockcross-Makefile
    for image in $(make -f dockcross-Makefile display_images); do
      if [[ $(docker images -q dockcross/$image) == "" ]]; then
        echo "~/bin/dockcross-$image skipping: image not found locally"
        continue
      fi
      echo "~/bin/dockcross-$image ok"
      docker run dockcross/$image > ~/bin/dockcross-$image && \
      chmod u+x  ~/bin/dockcross-$image
    done

## Dockcross configuration

The following environmental variables and command-line options are used.
In all cases, the command-line option overrides the environment
variable.

### DOCKCROSS_CONFIG / \--config\|-c \<path-to-config-file>

This file is sourced, if it exists, before executing the rest of the
dockcross script.

Default: `~/.dockcross`

### DOCKCROSS_IMAGE / \--image\|-i \<docker-image-name>

The Docker cross-compiler image to run.

Default: Image with which the script was created.

### DOCKCROSS_ARGS / \--args\|-a \<docker-run-args>

Extra arguments to pass to the `docker run` command. Quote the entire
set of args if they contain spaces.

## Per-project dockcross configuration

If a shell script named `.dockcross` is found in the current directory
where the dockcross script is started, it is executed before the
dockcross script `command` argument. The shell script is expected to
have a shebang like `#!/usr/bin/env bash`.

For example, commands like
`git config --global advice.detachedHead false` can be added to this
script.

## How to extend Dockcross images

In order to extend Dockcross images with your own commands, one must:

1.  Use `FROM dockcross/<name_of_image>`.
2.  Set `DEFAULT_DOCKCROSS_IMAGE` to a name of the tag you\'re planning
    to use for the image. This tag must then be used during the build
    phase, unless you mean to pass the resulting helper script the
    `DOCKCROSS_IMAGE` argument.

An example Dockerfile would be:

    FROM dockcross/linux-armv7

    ENV DEFAULT_DOCKCROSS_IMAGE my_cool_image
    RUN apt-get install nano

And then in the shell:

    docker build -t my_cool_image .                   ## Builds the dockcross image.
    docker run my_cool_image > linux-armv7                ## Creates a helper script named linux-armv7.
    chmod +x linux-armv7                          ## Gives the script execution permission.
    ./linux-armv7 bash                            ## Runs the helper script with the argument "bash", which starts an interactive container using your extended image.

## What is the difference between [dockcross]{.title-ref} and [dockbuild]{.title-ref} ?

The key difference is that
[dockbuild](https://github.com/dockbuild/dockbuild#readme) images do
**NOT** provide a [toolchain
file](https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html)
but they use the same method to conveniently isolate the build
environment as
[dockcross](https://github.com/dockcross/dockcross#readme).

[dockbuild]{.title-ref} is used to build binaries for Linux x86_64 /
amd64 that will work across most Linux distributions.
[dockbuild]{.title-ref} performs a native Linux build where the host
build system is a Linux x86_64 / amd64 Docker image (so that it can be
used for building binaries on any system which can run Docker images)
and the target runtime system is Linux x86_x64 / amd64.

[dockcross]{.title-ref} is used to build binaries for many different
platforms. [dockcross]{.title-ref} performs a cross compilation where
the host build system is a Linux x86_64 / amd64 Docker image (so that it
can be used for building binaries on any system which can run Docker
images) and the target runtime system varies.

\-\--

Credits go to
[sdt/docker-raspberry-pi-cross-compiler](https://github.com/sdt/docker-raspberry-pi-cross-compiler),
who invented the base of the **dockcross** script.
