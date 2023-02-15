QEMU_DIR ?= ../qemu/
PROJ := $(CURDIR)

VERSION ?= latest

.PHONY: all
all: debian debian-kernel qemu aarch64

%-push: %
	docker push beshleman/$<:$(VERSION)

.PHONY: debian
debian: debian-$(VERSION).dockerfile
	docker build -t beshleman/$@:$(VERSION) . -f $<

.PHONY: debian-kernel
debian-kernel: debian-kernel-$(VERSION).dockerfile
	docker build -t beshleman/$@:$(VERSION) . -f $<
