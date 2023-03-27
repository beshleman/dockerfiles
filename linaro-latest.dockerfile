FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get --quiet --yes install \
        apt-transport-https \
        bc \
        build-essential \
        ca-certificates \
        check \
        curl \
        gcc-multilib \
        git \
        libssl-dev \
        linux-headers-generic \
        pkg-config \
        python2.7-dev \
        python3-pip \
        python3-virtualenv \
	libncursesw5-dev \
        software-properties-common \
        wget \
    &&  \
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
