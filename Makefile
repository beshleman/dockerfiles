QEMU_DIR ?= ../qemu/
PROJ := $(CURDIR)

.PHONY: all
all: debian qemu

qemu: qemu-build qemu-push
debian: debian-build debian-push
python: python-build

debian-build: debian.dockerfile
	docker build -t beshleman/debian:latest . -f $<

.PHONY: debian-push
debian-push:
	docker push beshleman/debian:latest

qemu-build: qemu.dockerfile
	cd $(QEMU_DIR) && docker build -t beshleman/qemu:latest . -f $(PROJ)/$<

python-build: python.dockerfile
	docker build -t beshleman/python:latest . -f $(PROJ)/$<

.PHONY: qemu-push
qemu-push:
	docker push beshleman/qemu:latest
