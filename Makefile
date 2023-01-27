QEMU_DIR ?= ../qemu/
PROJ := $(CURDIR)

.PHONY: all
all: debian debian-kernel qemu

.PHONY: %-push
%-push: %
	docker push beshleman/$<:latest

.PHONY:
%: %.dockerfile
	docker build -t beshleman/$@:latest . -f $<
