FROM debian:bullseye

RUN echo 'deb-src http://deb.debian.org/debian bullseye main' >> /etc/apt/sources.list

RUN apt-get update && apt-get upgrade
RUN apt-get install -y \
	vim \
	build-essential \
	linux-source \
	bc \
	kmod \
	cpio \
	flex \
	libncurses5-dev \
	libelf-dev \
	libssl-dev \
	dwarves \
	bison

RUN apt-get build-dep -y qemu
RUN apt-get install -y \
	git \
	rsync \
	silversearcher-ag

RUN apt-get install -y \
	aptitude

RUN apt-get install -y \
	git-email \
	libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev \
	libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev \
	libibverbs-dev libncurses5-dev libnuma-dev \
	librbd-dev librdmacm-dev \
	libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev \
	libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev \
	valgrind xfslibs-dev 

# Pahole
RUN apt-get install -y cmake libdw-dev wget
RUN mkdir /tmpgit && \
	cd /tmpgit && git clone --recurse-submodules git://git.kernel.org/pub/scm/devel/pahole/pahole.git && \
	cd pahole && \
	mkdir build && \
	cd build && \
	cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF .. && \
	make install && \
	cd && \
	rm -R /tmpgit

RUN apt-get install -y python3 python3-pip b4

ENV PATH="${PATH}:/opt/local/bin"

# selftests/bpf/vmtest.sh
RUN apt-get install -y curl sudo zstd

RUN apt-get install -y \
	lsb-release \
	software-properties-common \
	apt-utils

RUN wget https://apt.llvm.org/llvm.sh && \
	chmod +x llvm.sh && \
	sudo ./llvm.sh 15 all && \
	cd /usr/lib/llvm-15/bin/ && \
	for f in *; do ln -sf ../lib/llvm-15/bin/$f /usr/bin/$f; done && \
	cd / && \
	rm ./llvm.sh

RUN apt-get install -y qemu-utils qemu-system
RUN wget https://download.qemu.org/qemu-7.2.0.tar.xz && \
	tar xvJf qemu-7.2.0.tar.xz && \
	cd qemu-7.2.0 && \
	./configure \
		--target-list="x86_64-softmmu,aarch64-softmmu,riscv64-softmmu" \
		--enable-slirp \
		--enable-system \
		--enable-vhost-vdpa \
		--enable-vduse-blk-export \
		--enable-vhost-user \
		--enable-vhost-net \
		--enable-kvm && \
	make && \
	make install && \
	cd .. && \
	rm -R qemu-7.2.0 && \
	rm qemu-7.2.0.tar.xz

RUN pip install pyelftools
RUN apt-get install -y \
	fakeroot \
	gcc-10-aarch64-linux-gnu \
	crossbuild-essential-arm64 \
	debootstrap \
	busybox

# For qemu-arm-img-builder
RUN apt-get install -y \
	parted \
	udev

RUN apt-get install -y \
	bridge-utils

RUN apt-get install -y \
	--no-install-recommends \
	libvirt-clients \
	libvirt-daemon-system

RUN mkdir -p /etc/qemu/
RUN echo "allow all" | tee /etc/qemu/root.conf
RUN echo "include /etc/qemu/root.conf" | tee --append /etc/qemu/bridge.conf
RUN chown root:root /etc/qemu/root.conf
RUN chmod 640 /etc/qemu/root.conf
RUN mkdir -p /usr/local/etc/qemu/
RUN ln -sf /etc/qemu/bridge.conf /usr/local/etc/qemu/bridge.conf

RUN python3 -m pip install click requests

RUN python3 -m pip install --user --upgrade b4

# Install everything we need to build perf tools
RUN apt-get build-dep -y \
	linux-perf

# Install Linux v6.2-rc5 headers
RUN wget "https://git.kernel.org/torvalds/t/linux-6.2-rc5.tar.gz" && \
	tar xvf linux-6.2-rc5.tar.gz && \
	cd linux-6.2-rc5 && \
		make headers_install INSTALL_HDR_PATH=/usr && \
		cd tools/perf && \
			make prefix=/usr/local install && \
		cd ../.. && \
	cd .. && \
	rm -f linux-6.2-rc5.tar.gz && \
	rm -Rf linux-6.2-rc5
