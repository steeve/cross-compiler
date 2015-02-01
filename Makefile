DOCKER = docker
IMAGE = rburns/cross-compiler

android-arm:
	$(DOCKER) build -t $(IMAGE):android-arm linux-arm

darwin-x64:
	$(DOCKER) build -t $(IMAGE):darwin-x64 darwin-x64

linux-x86:
	$(DOCKER) build -t $(IMAGE):darwin-x86 darwin-x86

linux-x64:
	$(DOCKER) build -t $(IMAGE):linux-x64 linux-x64

linux-armv6:
	$(DOCKER) build -t $(IMAGE):linux-armv6 linux-armv6

linux-armv7:
	$(DOCKER) build -t $(IMAGE):linux-armv7 linux-armv7

windows-x86:
	$(DOCKER) build -t $(IMAGE):windows-x86 windows-x86

windows-x64:
	$(DOCKER) build -t $(IMAGE):windows-x64 windows-x64

base:
	$(DOCKER) build -t $(IMAGE):base .

all: base android-arm darwin-x64 linux-x86 linux-x64 linux-armv6 linux-armv7 windows-x86 windows-x64

.PHONY: all base android-arm darwin-x64 linux-x86 linux-x64 linux-armv6 linux-armv7 windows-x86 windows-x64
