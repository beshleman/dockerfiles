FROM python:3.11.2-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get --quiet --yes install \
	libffi-dev \
    &&  \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/*

RUN python3 -m pip install --user b4
ENV PATH /root/.local/bin/:$PATH

ENTRYPOINT ["/root/.local/bin/b4"]
