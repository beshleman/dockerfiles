QEMU_DIR ?= ../qemu/
PROJ := $(CURDIR)

VERSION ?= latest

.PHONY: all
all: debian debian-kernel qemu aarch64 uperf linaro b4

%-push: %
	docker push beshleman/$<:$(VERSION)

.PHONY: debian
debian: debian-$(VERSION).dockerfile
	docker build -t beshleman/$@:$(VERSION) . -f $<

.PHONY: debian-kernel
debian-kernel: debian-kernel-$(VERSION).dockerfile
	docker build -t beshleman/$@:$(VERSION) . -f $<

.PHONY: uperf
uperf: uperf-$(VERSION).dockerfile
	docker build -t beshleman/$@-build:$(VERSION) . -f $@-$(VERSION)-build.dockerfile
	docker build -t beshleman/$@:$(VERSION) . -f $<

.PHONY: linaro
linaro: linaro-$(VERSION).dockerfile
	docker build -t beshleman/$@:$(VERSION) . -f $<

.PHONY: b4
b4: b4-$(VERSION).dockerfile
	docker build -t beshleman/$@:$(VERSION) . -f $<
