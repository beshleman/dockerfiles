FROM python:latest

RUN apt-get update
RUN apt-get install -y vim

RUN pip3 install \
	openai-cli


CMD ["bash"]
