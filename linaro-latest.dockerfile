FROM debian:bullseye-slim

RUN echo 'deb-src http://deb.debian.org/debian bullseye main' >> /etc/apt/sources.list

RUN apt-get update -y
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
		wget \
		bison && \
        apt-get autoremove -y && \
        apt-get clean && \
	rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/*

RUN mkdir -p /opt/linaro/aarch64
RUN cd /opt/linaro/aarch64 && \
	wget --quiet --output-document linaro-cross.tar.xz \
		https://developer.arm.com/-/media/Files/downloads/gnu/12.2.rel1/binrel/arm-gnu-toolchain-12.2.rel1-x86_64-aarch64-none-linux-gnu.tar.xz && \
		tar xvf linaro-cross.tar.xz --strip-components=1 && \
		pwd && ls && \
	rm linaro-cross.tar.xz

ENV PATH /opt/linaro/aarch64/bin:$PATH

# Set the arch for linux
ENV ARCH arm64

# Set the cross compiler prefix for linux
ENV CROSS_COMPILE aarch64-none-linux-gnu-
