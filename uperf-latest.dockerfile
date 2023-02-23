FROM alpine:latest

COPY --from=beshleman/uperf-build:latest /usr/local/bin/uperf /usr/local/bin/uperf

ENTRYPOINT ["uperf"]
