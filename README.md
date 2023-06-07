# dockerfiles

This project provides convenient Makefile targets for building various containers.

## Targets

- `all`: Builds all targets: debian, debian-kernel, qemu, aarch64, uperf, linaro, b4.
- `<target>-push`: Pushes a specific target to the Docker registry.
- `debian`: Builds the Debian target.
- `debian-kernel`: Builds the Debian kernel target.
- `uperf`: Builds the uperf target.
- `linaro`: Builds the linaro target.
- `b4`: Builds the b4 target.
- `qemu`: Builds the qemu target.

## Usage

To build a specific target, run the following command:

```bash

make <target>
```

To build a specific version, run the following command:

```bash

VERSION=<version> make <target>
```

For example, to build the 5.10 debian container:

```bash

VERSION=5.10 make debian
```

The default version for all targets is `latest`.
