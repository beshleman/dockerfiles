FROM debian:bullseye

COPY --from=beshleman/qemu-build:latest /usr/local/share/qemu /usr/local/share/qemu
COPY --from=beshleman/qemu-build:latest \
	/usr/local/bin/qemu-system-x86_64 /usr/local/bin/qemu-system-x86_64

RUN apt-get update && \
	apt-get install -y  --no-install-recommends \
		libpixman-1-0 \
		libfdt1 \
		libslirp0 && \
	apt-get clean && \
	apt-get autoremove

ENTRYPOINT ["qemu-system-x86_64"]
