FROM debian:bullseye-slim

RUN echo 'deb-src http://deb.debian.org/debian bullseye main' >> /etc/apt/sources.list

RUN apt-get update && \
	apt build-dep -y qemu && \
	apt-get install -y  --no-install-recommends git wget && \
	apt-get clean && \
	apt-get autoremove

RUN git clone https://github.com/beshleman/qemu.git --single-branch --branch vsock-dgram /qemu && \
	cd /qemu && \
	wget https://gist.githubusercontent.com/beshleman/78a91b07ffe132e225a2f16b2a9484f2/raw/117cc5ea81e5f9562a68483df32b6aeefbdc37b5/configure_qemu.sh && \
	bash ./configure_qemu.sh && \
	make -j$(nproc) && \
	make install && \
	cd && \
	rm -R /qemu
