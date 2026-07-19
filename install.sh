#!/bin/bash

set -e

echo "Installing custom htop..."

apt update

apt install -y libsensors5

dpkg -i htop-custom_3.6.0-1_arm64.deb

echo "Done"

htop -V
