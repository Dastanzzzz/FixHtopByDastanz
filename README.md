# htop Custom Build for Amlogic STB / Armbian

Custom **htop build with lm-sensors support** for Amlogic-based STB devices running Armbian.

This project provides a ready-to-install Debian package (`.deb`) so the custom htop build can be restored quickly after reinstalling Armbian.

## Features

This custom build enables:

* Linux hwmon sensor support
* lm-sensors integration
* Amlogic SCPI thermal sensor detection
* CPU temperature monitoring inside htop

No need to run:

```
HTOP_DEBUG=1 htop
```

Temperature will appear automatically.

---

# Tested Environment

| Component          | Information            |
| ------------------ | ---------------------- |
| Device             | Amlogic S9xx based STB |
| OS                 | Armbian Trixie         |
| Architecture       | ARM64 / aarch64        |
| Kernel             | Linux 6.x              |
| Sensor Driver      | SCPI sensors           |
| Temperature Source | hwmon                  |

---

# Why Custom Build?

Some repository versions of htop are built without sensor support.

Without sensor support:

* CPU temperature does not appear in htop
* lm-sensors integration is unavailable

This build was compiled with:

```
(Linux) sensors: yes
```

so htop can read:

```
/sys/class/hwmon/
```

Example sensor:

```
scpi_sensors
└── temp1_input
```

Example value:

```
39000
```

means:

```
39°C
```

---

# Installation (Recommended)

## Install From Debian Package

Download the package:

```
htop-custom_3.6.0-1_arm64.deb
```

Install:

```
sudo dpkg -i htop-custom_3.6.0-1_arm64.deb
```

Verify:

```
htop -V
```

Run:

```
htop
```

Temperature should appear automatically.

---

# Repository Structure

Recommended repository layout:

```
aml-s9xx-htop/
|
├── README.md
├── install.sh
└── packages/
    └── htop-custom_3.6.0-1_arm64.deb
```

---

# Automated Installation

The installation script will automatically install the custom htop package.

Run:

    chmod +x install.sh

    sudo ./install.sh

After installation, verify:

    htop -V

Run htop:

    htop

Temperature monitoring should appear automatically.

---

After reinstalling Armbian:

    git clone https://github.com/YOUR_USERNAME/aml-s9xx-htop.git

    cd aml-s9xx-htop

    sudo ./install.sh

# Build Information

Current package:

```
htop-custom_3.6.0-1_arm64.deb
```

Source version:

```
htop 3.6.0-dev-3.5.2-5-gd4297a4
```

Build configuration:

```
(Linux) sensors: yes
```

---

# Manual Build

Only needed if rebuilding from source.

Install dependencies:

```
sudo apt update

sudo apt install -y \
build-essential \
autoconf \
automake \
pkg-config \
libsensors-dev \
libncurses-dev \
git
```

Clone htop:

```
git clone https://github.com/htop-dev/htop.git

cd htop
```

Generate build files:

```
./autogen.sh
```

Configure:

```
./configure
```

Verify:

```
(Linux) sensors: yes
```

Compile:

```
make -j$(nproc)
```

Install:

```
sudo make install
```

---

# Troubleshooting

## Check Sensor Availability

Run:

```
sensors
```

Expected:

```
scpi_sensors-isa-0000

aml_thermal:
temp1_input: 38.0°C
```

---

## Check hwmon

Run:

```
ls -l /sys/class/hwmon/
```

Expected:

```
hwmon0 -> scpi_sensors
```

---

## Check Temperature Value

Run:

```
cat /sys/class/hwmon/hwmon0/temp1_input
```

Example:

```
38000
```

Meaning:

```
38°C
```

---

# Purpose

This repository is intended as a recovery package for Amlogic STB devices.

After reinstalling Armbian or replacing storage, the custom htop temperature monitoring setup can be restored without recompiling.

Installation only requires:

```
dpkg -i htop-custom_3.6.0-1_arm64.deb
```

---

# License

This repository contains build scripts and packaging files.

htop itself is licensed under the GNU General Public License (GPL).
