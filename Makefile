DOCKER = docker
ORG = dockcross

android-arm: base android-arm/Dockerfile
	$(DOCKER) build -t $(ORG)/android-arm android-arm

darwin-x64:
	$(DOCKER) build -t $(ORG)/darwin-x64 darwin-x64

browser-asmjs: base browser-asmjs/Dockerfile
	cp -r test browser-asmjs/
	$(DOCKER) build -t $(ORG)/browser-asmjs browser-asmjs
	rm -rf browser-asmjs/test

linux-x86: base linux-x86/Dockerfile linux-x86/Toolchain.cmake
	$(DOCKER) build -t $(ORG)/linux-x86 linux-x86

linux-x64: base linux-x64/Dockerfile
	$(DOCKER) build -t $(ORG)/linux-x64 linux-x64

linux-arm64: base linux-arm64/Dockerfile linux-arm64/Toolchain.cmake
	$(DOCKER) build -t $(ORG)/linux-arm64 linux-arm64

linux-armv5: base linux-armv5/Dockerfile linux-armv5/Toolchain.cmake
	$(DOCKER) build -t $(ORG)/linux-armv5 linux-armv5

linux-armv6: base linux-armv6/Dockerfile linux-armv6/Toolchain.cmake
	$(DOCKER) build -t $(ORG)/linux-armv6 linux-armv6

linux-armv7: base linux-armv7/Dockerfile linux-armv7/Toolchain.cmake
	$(DOCKER) build -t $(ORG)/linux-armv7 linux-armv7

linux-ppc64le: base linux-ppc64le/Dockerfile linux-ppc64le/Toolchain.cmake
	$(DOCKER) build -t $(ORG)/linux-ppc64le linux-ppc64le

windows-x86: base windows-x86/Dockerfile windows-x86/settings.mk
	$(DOCKER) build -t $(ORG)/windows-x86 windows-x86

windows-x64: base windows-x64/Dockerfile windows-x64/settings.mk
	$(DOCKER) build -t $(ORG)/windows-x64 windows-x64

base: Dockerfile
	$(DOCKER) build -t $(ORG)/base .

all: base android-arm darwin-x64 linux-x86 linux-x64 linux-arm64 linux-armv5 linux-armv6 linux-armv7 windows-x86 windows-x64

.PHONY: all base android-arm darwin-x64 linux-x86 linux-x64 linux-arm64 linux-armv5 linux-armv6 linux-armv7 windows-x86 windows-x64
