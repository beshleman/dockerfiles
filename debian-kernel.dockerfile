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
