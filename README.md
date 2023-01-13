# dockerfiles

This project contains a Dockerfile and a Makefile that can be used for create a build and test environment for the Linux kernel.
The Dockerfile sets up a development environment with various tools and libraries that are commonly used for kernel development,
such as gcc, qemu, and pahole.

The Makefile provides commands for building and pushing the Docker images to a container registry.

## Getting Started

To use this project, you will need to have [Docker](https://www.docker.com/) installed on your machine and be logged in to a
container registry where the images can be pushed.

1. Clone this repository:
```bash
git clone https://github.com/beshleman/dockerfiles.git
```

2. Navigate to the folder:
```bash
cd dockerfiles
```

3. Build and push the Docker image:
```bash
make
```

This will build the `beshleman/debian:latest` image and push it to a container registry.

Once the image is built and pushed, it can be pulled down and run on any machine with Docker installed.

**Note**: This project is focused on building and testing the Linux kernel, however, you may use the image for other purposes as well.
