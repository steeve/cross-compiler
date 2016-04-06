cross-compilers
===============
Dockerfiles for cross compiling environments
--------------------------------------------

.. image:: https://circleci.com/gh/thewtex/cross-compilers/tree/master.svg?style=svg
  :target: https://circleci.com/gh/thewtex/cross-compilers/tree/master


.. |base-images| image:: https://badge.imagelayers.io/thewtex/cross-compiler-base:latest.svg
  :target: https://imagelayers.io/?images=thewtex/cross-compiler-base:latest

thewtex/cross-compiler-base
  |base-images| Base image for other toolchain images. From Debian Jessie with GCC,
  make, autotools, CMake, Ninja, Git, and Python.


.. |android-arm-images| image:: https://badge.imagelayers.io/thewtex/cross-compiler-android-arm:latest.svg
  :target: https://imagelayers.io/?images=thewtex/cross-compiler-android-arm:latest

thewtex/cross-compiler-android-arm
  |android-arm-images| The Android NDK standalone toolchain for the arm
  architecture.


.. |browser-asmjs-images| image:: https://badge.imagelayers.io/thewtex/cross-compiler-browser-asmjs:latest.svg
  :target: https://imagelayers.io/?images=thewtex/cross-compiler-browser-asmjs:latest

thewtex/cross-compiler-browser-asmjs
  |browser-asmjs-images| The Emscripten JavaScript cross compiler.


.. |linux-armv6-images| image:: https://badge.imagelayers.io/thewtex/cross-compiler-linux-armv6:latest.svg
  :target: https://imagelayers.io/?images=thewtex/cross-compiler-linux-armv6:latest

thewtex/cross-compiler-linux-armv6
  |linux-armv6-images| Linux ARMv6 cross compiler toolchain for the Raspberry
  Pi, etc.


.. |linux-armv7-images| image:: https://badge.imagelayers.io/thewtex/cross-compiler-linux-armv7:latest.svg
  :target: https://imagelayers.io/?images=thewtex/cross-compiler-linux-armv7:latest

thewtex/cross-compiler-linux-armv7
  |linux-armv7-images| Generic Linux armv7 cross compiler toolchain.


.. |linux-ppc64le-images| image:: https://badge.imagelayers.io/thewtex/cross-compiler-linux-ppc64le:latest.svg
  :target: https://imagelayers.io/?images=thewtex/cross-compiler-linux-ppc64le:latest

thewtex/cross-compiler-linux-ppc64le
  |linux-ppc64le-images| Linux PowerPC 64 little endian cross compiler
  toolchain for the POWER8, etc.


.. |linux-x64-images| image:: https://badge.imagelayers.io/thewtex/cross-compiler-linux-x64:latest.svg
  :target: https://imagelayers.io/?images=thewtex/cross-compiler-linux-x64:latest

thewtex/cross-compiler-linux-x64
  |linux-x64-images| Linux x86_64 / amd64 compiler. Since the Docker image is
  natively x86_64, this is not actually a cross compiler.


.. |linux-x86-images| image:: https://badge.imagelayers.io/thewtex/cross-compiler-linux-x86:latest.svg
  :target: https://imagelayers.io/?images=thewtex/cross-compiler-linux-x86:latest

thewtex/cross-compiler-linux-x86
  |linux-x86-images| Linux i686 compiler. Since the Docker image is
  natively x86_64 with i386 multi-arch support, this is not actually a cross compiler.
