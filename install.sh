#!/bin/bash

set -e

echo "======================================"
echo " Installing htop with sensor support "
echo "======================================"

# Install dependencies
apt update

apt install -y \
    git \
    build-essential \
    autoconf \
    automake \
    pkg-config \
    libsensors-dev \
    libncurses-dev


# Download source
WORKDIR="/tmp/htop-build"

rm -rf "$WORKDIR"

git clone \
    --depth 1 \
    https://github.com/htop-dev/htop.git \
    "$WORKDIR"


cd "$WORKDIR"


# Generate configure script
./autogen.sh


# Configure with lm-sensors support
./configure


# Build
make -j"$(nproc)"


# Install
make install


echo
echo "======================================"
echo " htop installed successfully"
echo "======================================"

htop -V
