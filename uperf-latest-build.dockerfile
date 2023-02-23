FROM alpine:latest

RUN apk -U --no-cache upgrade && \
	apk --no-cache add git autoconf automake build-base make linux-headers

RUN git clone https://github.com/uperf/uperf.git && \
	cd uperf && \
	autoreconf --install && \
	./configure --disable-sctp --disable-dependency-tracking && \
	make && \
	make install

RUN rm -R uperf
RUN apk del git autoconf automake build-base make linux-headers
