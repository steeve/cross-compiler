DOCKER = docker
ORG = dockcross
BIN = bin

STANDARD_IMAGES = android-arm linux-x86 linux-x64 linux-arm64 linux-armv5 linux-armv6 linux-armv7 windows-x86 windows-x64

IMAGES = $(STANDARD_IMAGES) manylinux-x64 manylinux-x86

STANDARD_TESTS = android-arm linux-x86 linux-x64 linux-arm64 linux-armv5 linux-armv6 linux-armv7

images: base $(IMAGES)

test: base.test $(addsuffix .test,$(IMAGES))

$(STANDARD_IMAGES): base
	$(DOCKER) build -t $(ORG)/$@ $@

.SECONDEXPANSION:
$(addsuffix .test,$(STANDARD_TESTS)): $$(basename $$@)
	$(DOCKER) run --rm dockcross/$(basename $@) > $(BIN)/dockcross-$(basename $@) && chmod +x $(BIN)/dockcross-$(basename $@)
	$(BIN)/dockcross-$(basename $@) python test/run.py

browser-asmjs: base
	cp -r test browser-asmjs/
	$(DOCKER) build -t $(ORG)/browser-asmjs browser-asmjs
	rm -rf browser-asmjs/test

browser-asmjs.test: browser-asmjs
	$(DOCKER) run --rm dockcross/browser-asmjs > $(BIN)/dockcross-browser-asmjs && chmod +x $(BIN)/dockcross-browser-asmjs
	$(BIN)/dockcross-browser-asmjs python test/run.py --exe-suffix ".js"

linux-ppc64le: base
	$(DOCKER) build -t $(ORG)/linux-ppc64le linux-ppc64le

linux-ppc64le.test: linux-ppc64le
	$(DOCKER) run --rm dockcross/linux-ppc64le > $(BIN)/dockcross-linux-ppc64le && chmod +x $(BIN)/dockcross-linux-ppc64le
	$(BIN)/dockcross-linux-ppc64le python test/run.py --languages C

manylinux-x64/Dockerfile: manylinux-x64/Dockerfile.in common.docker
	sed '/common.docker/ r common.docker' manylinux-x64/Dockerfile.in > manylinux-x64/Dockerfile

manylinux-x64: manylinux-x64/Dockerfile
	$(DOCKER) build -t $(ORG)/manylinux-x64 -f manylinux-x64/Dockerfile .

manylinux-x64.test: manylinux-x64
	$(DOCKER) run --rm dockcross/manylinux-x64 > $(BIN)/dockcross-manylinux-x64 && chmod +x $(BIN)/dockcross-manylinux-x64
	$(BIN)/dockcross-manylinux-x64 /opt/python/cp35-cp35m/bin/python test/run.py

manylinux-x86/Dockerfile: manylinux-x86/Dockerfile.in common.docker
	sed '/common.docker/ r common.docker' manylinux-x86/Dockerfile.in > manylinux-x86/Dockerfile

manylinux-x86: manylinux-x86/Dockerfile
	$(DOCKER) build -t $(ORG)/manylinux-x86 -f manylinux-x86/Dockerfile .

manylinux-x86.test: manylinux-x86
	$(DOCKER) run --rm dockcross/manylinux-x86 > $(BIN)/dockcross-manylinux-x86 && chmod +x $(BIN)/dockcross-manylinux-x86
	$(BIN)/dockcross-manylinux-x86 /opt/python/cp35-cp35m/bin/python test/run.py

windows-x86.test: windows-x86
	$(DOCKER) run --rm dockcross/windows-x86 > $(BIN)/dockcross-windows-x86 && chmod +x $(BIN)/dockcross-windows-x86
	$(BIN)/dockcross-windows-x86 python test/run.py  --exe-suffix ".exe"

windows-x64.test: windows-x64
	$(DOCKER) run --rm dockcross/windows-x64 > $(BIN)/dockcross-windows-x64 && chmod +x $(BIN)/dockcross-windows-x64
	$(BIN)/dockcross-windows-x64 python test/run.py --exe-suffix ".exe"

Dockerfile: Dockerfile.in common.docker
	sed '/common.docker/ r common.docker' Dockerfile.in > Dockerfile

base: Dockerfile
	$(DOCKER) build -t $(ORG)/base .

base.test: base
	mkdir -p $(BIN)
	$(DOCKER) run --rm dockcross/base > $(BIN)/dockcross-base && chmod +x $(BIN)/dockcross-base

.PHONY: base images $(IMAGES) tests %.test
