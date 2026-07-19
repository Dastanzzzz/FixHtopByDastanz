# htop build for Amlogic STB / Armbian

Custom htop build with Linux sensor support.

Tested on:

- Armbian Trixie
- Amlogic S9xx based STB
- ARM64 architecture

## Why custom build?

Default htop package may not include sensor support.

This build enables:

- lm-sensors support
- hwmon temperature reading
- SCPI sensor support

Example sensor:
