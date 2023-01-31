FROM beshleman/debian:latest
COPY . /qemu
RUN cd /qemu && \
	mkdir -p build && \
	cd build && \
	../configure --target-list="x86_64-softmmu" \
		--enable-slirp \
		--enable-system \
		--enable-vhost-vdpa \
		--enable-vduse-blk-export \
		--enable-vhost-user \
		--enable-vhost-net \
		--enable-kvm && \
	make -j$(nproc) && \
	make install && \
	cd && \
	rm -R /qemu
