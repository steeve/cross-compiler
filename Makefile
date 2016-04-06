DOCKER = docker
IMAGE = thewtex/cross-compiler

android-arm: base android-arm/Dockerfile
	$(DOCKER) build -t $(IMAGE)-android-arm android-arm

darwin-x64:
	$(DOCKER) build -t $(IMAGE)-darwin-x64 darwin-x64

browser-asmjs: base browser-asmjs/Dockerfile
	$(DOCKER) build -t $(IMAGE)-browser-asmjs browser-asmjs

linux-x86:
	$(DOCKER) build -t $(IMAGE)-linux-x86 linux-x86

linux-x64:
	$(DOCKER) build -t $(IMAGE)-linux-x64 linux-x64

linux-armv6: base linux-armv6/Dockerfile linux-armv6/Toolchain.cmake
	$(DOCKER) build -t $(IMAGE)-linux-armv6 linux-armv6

linux-armv7: base linux-armv7/Dockerfile linux-armv7/Toolchain.cmake
	$(DOCKER) build -t $(IMAGE)-linux-armv7 linux-armv7

linux-ppc64le: base linux-ppc64le/Dockerfile linux-ppc64le/Toolchain.cmake
	$(DOCKER) build -t $(IMAGE)-linux-ppc64le linux-ppc64le

windows-x86: base windows-x86/Dockerfile windows-x86/settings.mk
	$(DOCKER) build -t $(IMAGE)-windows-x86 windows-x86

windows-x64: base windows-x64/Dockerfile windows-x64/settings.mk
	$(DOCKER) build -t $(IMAGE)-windows-x64 windows-x64

base: Dockerfile
	$(DOCKER) build -t $(IMAGE)-base .

all: base android-arm darwin-x64 linux-x86 linux-x64 linux-armv6 linux-armv7 windows-x86 windows-x64

.PHONY: all base android-arm darwin-x64 linux-x86 linux-x64 linux-armv6 linux-armv7 windows-x86 windows-x64
