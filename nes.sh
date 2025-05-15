#!/bin/bash

# === CONFIGURASI AWAL DAN SETUP ===

# Nama folder untuk SRBMiner
MINER_DIR="$HOME/SRBMiner-Multi-2-7-5"

echo "=== Memastikan dependensi sistem ==="
sudo apt update
sudo apt install -y docker.io npm screen wget tar git

# === SETUP PROXY STRATUM ===

# Clone repo stratum-ethproxy
PROXY_DIR="$HOME/vec"
if [ ! -d "$PROXY_DIR" ]; then
    echo "Meng-clone stratum-ethproxy ke $PROXY_DIR..."
    git clone https://github.com/oneevil/stratum-ethproxy "$PROXY_DIR"
else
    echo "Repo stratum-ethproxy sudah ada, melewati cloning."
fi

# Setup dan jalankan 10 instance proxy
echo "Menyiapkan dan menjalankan 10 instance stratum proxy..."
for i in {1..10}; do
  cd "$PROXY_DIR" || exit 1
  npm install

  LOCAL_IP=$(hostname -I | awk '{print $1}')
  cat <<EOL > .env
REMOTE_HOST=stratum.vecocoin.com
REMOTE_PORT=8602
REMOTE_PASSWORD=x
LOCAL_HOST=$LOCAL_IP
LOCAL_PORT=$((442 + i))
EOL

  # Jalankan dalam screen
  SCREEN_NAME="vec_$i"
  sudo screen -dmS "$SCREEN_NAME" npm start

  if screen -list | grep -q "$SCREEN_NAME"; then
    echo "Screen session $SCREEN_NAME berhasil dijalankan."
  else
    echo "Gagal menjalankan screen session $SCREEN_NAME."
  fi
done

# === SETUP DAN JALANKAN MINER ===

# Pastikan mining sebelumnya dimatikan
echo "Mematikan mining sebelumnya jika ada..."
pkill -f SRBMiner-MULTI
sleep 5

# Cek dan unduh SRBMiner jika belum ada
if [ ! -d "$MINER_DIR" ]; then
    echo "SRBMiner belum ada, mengunduh..."
    wget -q https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.5/SRBMiner-Multi-2-7-5-Linux.tar.gz
    tar -xzf SRBMiner-Multi-2-7-5-Linux.tar.gz
    rm SRBMiner-Multi-2-7-5-Linux.tar.gz
else
    echo "Folder SRBMiner sudah tersedia."
fi

# Masuk ke folder SRBMiner dan jalankan
cd "$MINER_DIR" || exit 1
echo "Menjalankan SRBMiner..."
./SRBMiner-MULTI  -a yespower  \
  -o stratum+tcp://stratum.vecocoin.com:8602 \
  -u VGq2bKrQ2AiJPNwttzKw7FE8RZJSQQva3G.workercron \
  -p c=VECO,m=solo,zap=VECO,mc=VECO


# Jalankan miner
# ./SRBMiner-MULTI  -a yespower  -o stratum+tcp://stratum.vecocoin.com:8602 -u VGq2bKrQ2AiJPNwttzKw7FE8RZJSQQva3G.workercron -p c=VECO,m=solo,zap=VECO,mc=VECO
# ./SRBMiner-MULTI  -a yespower  -o stratum+tcp://yespower.asia.mine.zergpool.com:6533 -u WbpHqVBkysEDZLvX3TQJ4HZwZ2yWzoJwbZ.workercron -p c=SWAMP,m=solo,zap=SWAMP,mc=SWAMP
