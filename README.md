
# Compile and Install of the Xyce Circuit Simulator

This repository contains a **make** file for easy compile and install of [Xyce](https://xyce.sandia.gov).
Xyce (zīs, rhymes with “spice”) is an open source, SPICE-compatible, high-performance analog circuit simulator,
capable of solving extremely large circuit problems by supporting large-scale parallel computing platforms.


# Get Source Code

## ed_xyce

```bash
git clone https://github.com/embed-dsp/ed_xyce.git
```

## Xyce

```bash
# Enter the ed_xyce directory.
cd ed_xyce

# Edit the Makefile for selecting the Xyce version and the Trilinos library version.
vim Makefile
PACKAGE_VERSION = 7.8
TRILINOS_VERSION = release-12-12-1
```

Download [Xyce source](https://xyce.sandia.gov/sign-in/) package and place in the `src/` directory.


# Build

**NOTE**: It is necessary to build and install the [Trilinos](https://github.com/embed-dsp/ed_trilinos) library before continuing with the following steps.

```bash
# Unpack source code into build/ directory.
make prepare
```

**NOTE**: Select one of the following configuration options depending on if you want to build Xyce in "normal" configuration or for parallell computing using [OpenMPI](https://www.open-mpi.org).

```bash
# Configure source code.
make configure
```

```bash
# Configure source code.
make configure SERPAR=parallel
```


# Install

```bash
# Install build products.
sudo make install
```


# Links

* https://xyce.sandia.gov
* https://xyce.sandia.gov/documentation-tutorials/building-guide

## GitHub

* https://github.com/Xyce
* https://github.com/Xyce/Xyce
* https://github.com/Xyce/Xyce_Regression
