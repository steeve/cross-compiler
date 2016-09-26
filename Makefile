
#
# Parameters
#

# Name of the docker executable
DOCKER = docker

# Docker organization to pull the images from
ORG = dockcross

# Directory where to generate the dockcross script for each images (e.g bin/dockcross-manylinux-x64)
BIN = bin

# These images are built using the "build implicit rule"
STANDARD_IMAGES = android-arm linux-x86 linux-x64 linux-arm64 linux-armv5 linux-armv6 linux-armv7 linux-ppc64le windows-x86 windows-x64

# These images are expected to have explicit rules for *both* build and testing
NON_STANDARD_IMAGES = browser-asmjs manylinux-x64 manylinux-x86

# This list all available images
IMAGES = $(STANDARD_IMAGES) $(NON_STANDARD_IMAGES)

# Optional arguments for test runner (test/run.py) associated with "testing implicit rule"
linux-ppc64le.test_ARGS = --languages C
windows-x86.test_ARGS = --exe-suffix ".exe"
windows-x64.test_ARGS = --exe-suffix ".exe"

#
# images: This target builds all IMAGES (because it is the first one, it is built by default)
#
images: base $(IMAGES)

#
# test: This target ensures all IMAGES are built and run the associated tests
#
test: base.test $(addsuffix .test,$(IMAGES))

#
# browser-asmjs
#
browser-asmjs: base
	cp -r test browser-asmjs/
	$(DOCKER) build -t $(ORG)/browser-asmjs browser-asmjs
	rm -rf browser-asmjs/test

browser-asmjs.test: browser-asmjs
	$(DOCKER) run --rm dockcross/browser-asmjs > $(BIN)/dockcross-browser-asmjs && chmod +x $(BIN)/dockcross-browser-asmjs
	$(BIN)/dockcross-browser-asmjs python test/run.py --exe-suffix ".js"

#
# manylinux-x64
#
manylinux-x64/Dockerfile: manylinux-x64/Dockerfile.in common.docker
	sed '/common.docker/ r common.docker' manylinux-x64/Dockerfile.in > manylinux-x64/Dockerfile

manylinux-x64: manylinux-x64/Dockerfile
	$(DOCKER) build -t $(ORG)/manylinux-x64 -f manylinux-x64/Dockerfile .

manylinux-x64.test: manylinux-x64
	$(DOCKER) run --rm dockcross/manylinux-x64 > $(BIN)/dockcross-manylinux-x64 && chmod +x $(BIN)/dockcross-manylinux-x64
	$(BIN)/dockcross-manylinux-x64 /opt/python/cp35-cp35m/bin/python test/run.py

#
# manylinux-x86
#
manylinux-x86/Dockerfile: manylinux-x86/Dockerfile.in common.docker
	sed '/common.docker/ r common.docker' manylinux-x86/Dockerfile.in > manylinux-x86/Dockerfile

manylinux-x86: manylinux-x86/Dockerfile
	$(DOCKER) build -t $(ORG)/manylinux-x86 -f manylinux-x86/Dockerfile .

manylinux-x86.test: manylinux-x86
	$(DOCKER) run --rm dockcross/manylinux-x86 > $(BIN)/dockcross-manylinux-x86 && chmod +x $(BIN)/dockcross-manylinux-x86
	$(BIN)/dockcross-manylinux-x86 /opt/python/cp35-cp35m/bin/python test/run.py

#
# base
#
Dockerfile: Dockerfile.in common.docker
	sed '/common.docker/ r common.docker' Dockerfile.in > Dockerfile

base: Dockerfile
	$(DOCKER) build -t $(ORG)/base .

base.test: base
	mkdir -p $(BIN)
	$(DOCKER) run --rm dockcross/base > $(BIN)/dockcross-base && chmod +x $(BIN)/dockcross-base

#
# display
#
display_images:
	for image in $(IMAGES); do echo $$image; done

$(VERBOSE).SILENT: display_images

#
# build implicit rule
#
$(STANDARD_IMAGES): base
	$(DOCKER) build -t $(ORG)/$@ $@

#
# testing implicit rule
#
.SECONDEXPANSION:
$(addsuffix .test,$(STANDARD_IMAGES)): $$(basename $$@)
	$(DOCKER) run --rm dockcross/$(basename $@) > $(BIN)/dockcross-$(basename $@) && chmod +x $(BIN)/dockcross-$(basename $@)
	$(BIN)/dockcross-$(basename $@) python test/run.py $($@_ARGS)

.PHONY: base images $(IMAGES) test %.test
