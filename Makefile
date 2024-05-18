
# Copyright (c) 2022-2024 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


# Select between serial or parallel (Open MPI) builds.
SERPAR = serial
# SERPAR = parallel

PACKAGE_NAME = Xyce
PACKAGE_VERSION = 7.8
PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

TRILINOS_VERSION = release-12-12-1

# ==============================================================================

# Determine system.
SYSTEM = unknown
ifeq ($(findstring Linux, $(shell uname -s)), Linux)
	SYSTEM = linux
endif
ifeq ($(findstring MINGW32, $(shell uname -s)), MINGW32)
	SYSTEM = mingw32
endif
ifeq ($(findstring MINGW64, $(shell uname -s)), MINGW64)
	SYSTEM = mingw64
endif

# Determine machine.
MACHINE = $(shell uname -m)

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

# ==============================================================================

# Set number of simultaneous jobs (Default 8)
ifeq ($(J),)
	J = 8
endif

CONFIGURE_FLAGS = --enable-stokhos --enable-amesos2

# Configuration for linux system.
ifeq ($(SYSTEM),linux)
	ifeq ($(SERPAR),serial)
		# Compiler.
		CC = /usr/bin/gcc
		CXX = /usr/bin/g++
	endif

	ifeq ($(SERPAR),parallel)
		# FIXME: Open MPI Compiler.
		CC = /usr/bin/gcc
		CXX = /usr/bin/g++

		CONFIGURE_FLAGS += --enable-mpi
	endif

	# Installation directory.
	INSTALL_DIR = /opt
endif

# Configuration for mingw64 system.
# ifeq ($(SYSTEM),mingw64)
# 	# Compiler.
# 	CC = /mingw64/bin/gcc
# 	CXX = /mingw64/bin/g++
# 	# Installation directory.
# 	INSTALL_DIR = /c/opt
# endif

CXXFLAGS = -O2

# ...
TRILINOS = /opt/trilinos/$(ARCH)/trilinos-$(TRILINOS_VERSION)-$(SERPAR)

# Installation directory.
PREFIX = $(INSTALL_DIR)/$(PACKAGE_NAME)/$(ARCH)/$(PACKAGE)-$(SERPAR)

# ==============================================================================

all:
	@echo "ARCH   = $(ARCH)"
	@echo "PREFIX = $(PREFIX)"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure [SERPAR=parallel]"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "[sudo] make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo "make distclean"
	@echo ""


.PHONY: prepare
prepare:
	-mkdir build
	cd build && tar zxf ../src/$(PACKAGE).tar.gz


.PHONY: configure
configure:
	cd build/$(PACKAGE) && ./configure CXX=$(CXX) CXXFLAGS=$(CXXFLAGS) ARCHDIR=$(TRILINOS) --prefix=$(PREFIX) $(CONFIGURE_FLAGS)


.PHONY: compile
compile:
	cd build/$(PACKAGE) && make -j$(J)


.PHONY: install
install:
	cd build/$(PACKAGE) && make install


.PHONY: clean
clean:
	cd build/$(PACKAGE) && make clean


.PHONY: distclean
distclean:
	cd build/$(PACKAGE) && make distclean
