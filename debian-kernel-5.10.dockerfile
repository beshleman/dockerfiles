FROM debian:bullseye

RUN echo 'deb-src http://deb.debian.org/debian bullseye main' >> /etc/apt/sources.list

RUN apt-get update && apt-get upgrade
RUN apt-get install -y \
	build-essential \
	bc \
	kmod \
	cpio \
	flex \
	libncurses5-dev \
	libelf-dev \
	libssl-dev \
	dwarves \
	bison

RUN apt-get install -y \
	software-properties-common \
	gnupg

RUN apt-get install -y \
	wget \
	git

RUN apt-get install -y \
	ccache

# Generate the initramfs
RUN apt-get install -y \
	initramfs-tools

# Install everything we need to build perf tools
RUN apt-get build-dep -y \
	linux-perf

# Build / install pahole for building eBPF
RUN apt-get install -y \
	cmake
RUN mkdir /tmpgit && \
	cd /tmpgit && \
	git clone --recurse-submodules git://git.kernel.org/pub/scm/devel/pahole/pahole.git && \
	cd pahole && \
	git checkout v1.23 && \
	mkdir build && \
	cd build && \
	cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF .. && \
	make install && \
	cd && \
	rm -R /tmpgit
