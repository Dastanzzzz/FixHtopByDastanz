# htop Build untuk Amlogic STB / Armbian

Custom build **htop** dengan dukungan sensor Linux agar temperatur CPU/STB dapat tampil langsung di htop.

Repository: [Dastanzzzz/FixHtopByDastanz](https://github.com/Dastanzzzz/FixHtopByDastanz)

## Tested On

- Armbian Trixie
- STB berbasis Amlogic S9xx
- Arsitektur ARM64
- Sensor berbasis `hwmon`, termasuk `scpi_sensors`

## Kenapa Perlu Custom Build?

Paket `htop` bawaan repository Armbian/Debian belum tentu menyertakan dukungan `lm-sensors`. Akibatnya, suhu CPU mungkin tidak tampil di htop walaupun sensor telah tersedia di sistem.

Build ini mengaktifkan:

- Dukungan `lm-sensors`
- Pembacaan temperatur melalui `hwmon`
- Dukungan sensor Amlogic/SCPI
- Tampilan temperatur CPU pada meter CPU htop

Contoh sensor yang dapat terbaca:

```text
scpi_sensors
temp1_input
```

## Instalasi

### 1. Install Git

```bash
sudo apt update
sudo apt install -y git
```

### 2. Clone Repository

```bash
git clone https://github.com/Dastanzzzz/FixHtopByDastanz.git
cd FixHtopByDastanz
```

### 3. Jalankan Installer

```bash
chmod +x install.sh
sudo ./install.sh
```

Installer akan memasang dependensi yang dibutuhkan lalu mengompilasi htop dengan dukungan sensor.

## Dependensi

Dependensi berikut akan diinstal otomatis oleh `install.sh`:

```text
libsensors-dev
libncurses-dev
build-essential
autoconf
automake
pkg-config
```

## Verifikasi

Setelah proses instalasi selesai, jalankan:

```bash
htop
```

Temperatur CPU seharusnya tampil langsung tanpa perlu menjalankan:

```bash
HTOP_DEBUG=1
```

Jika temperatur belum tampil, buka konfigurasi htop:

```text
F2 → Display options → Also show CPU temperature
```

## Cek Sensor dari Terminal

Pastikan sensor dapat dibaca oleh sistem:

```bash
sensors
```

Untuk memeriksa sensor SCPI secara langsung:

```bash
cat /sys/class/hwmon/hwmon*/name
cat /sys/class/hwmon/hwmon*/temp1_input
```

Nilai pada `temp1_input` biasanya menggunakan satuan milidegree Celsius.

Contoh:

```text
55000
```

Artinya temperatur perangkat sekitar **55°C**.

## Setelah Install Ulang Armbian

Jika STB di-install ulang, cukup jalankan kembali perintah berikut:

```bash
sudo apt update
sudo apt install -y git

git clone https://github.com/Dastanzzzz/FixHtopByDastanz.git
cd FixHtopByDastanz

chmod +x install.sh
sudo ./install.sh
```

Setelah selesai, htop dengan dukungan pembacaan temperatur akan kembali seperti sebelumnya.

## Catatan

- Build ini ditujukan terutama untuk STB Amlogic S9xx berbasis Armbian ARM64.
- Tampilan suhu tetap bergantung pada driver kernel dan sensor `hwmon` yang tersedia pada perangkat.
- Pastikan sensor seperti `scpi_sensors` terdeteksi pada sistem.
