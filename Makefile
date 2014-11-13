PLATFORMS = android-arm \
			darwin-x64 \
			linux-x86 \
			linux-x64 \
			linux-arm \
			windows-x86 \
			windows-x64
DOCKER = docker
IMAGE = steeve/cross-compiler

all:
	$(DOCKER) build -t $(IMAGE):base .
	for i in $(PLATFORMS); do \
		$(DOCKER) build -t $(IMAGE):$$i $$i ; \
	done
