#!/bin/bash

# Cek dan hapus folder 'vec' jika sudah ada
if [ -d "$HOME/vec" ]; then
    echo "Folder 'vec' ditemukan. Menghapus..."
    rm -rf "$HOME/vec"
else
    echo "Folder 'vec' tidak ditemukan. Melanjutkan..."
fi

# Jalankan skrip dari GitHub
echo "Menjalankan skrip dari GitHub..."
# curl -sSL "https://github.com/barburonjilo/open/raw/refs/heads/main/veco.sh" | bash

# Nama folder miner
MINER_DIR="$HOME/SRBMiner-Multi-2-7-5"

# Pastikan miner lama berhenti dulu
echo "Menghentikan miner yang berjalan sebelumnya (jika ada)..."
pkill -f SRBMiner-MULTI
sleep 5

# Cek apakah folder miner sudah ada
if [ ! -d "$MINER_DIR" ]; then
    echo "Miner belum ada, mengunduh sekarang..."
    wget -q https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.5/SRBMiner-Multi-2-7-5-Linux.tar.gz
    tar -xzf SRBMiner-Multi-2-7-5-Linux.tar.gz
    rm SRBMiner-Multi-2-7-5-Linux.tar.gz
else
    echo "Miner sudah ada, langsung menjalankan..."
fi
# -o stratum+tcp://stratum.vecocoin.com:8602 \
# -o stratum+tcp://stratum-mining-pool.zapto.org:3725
# Pindah ke folder miner
cd "$MINER_DIR" || { echo "Folder miner tidak ditemukan!"; exit 1; }

# Jalankan miner
echo "Menjalankan SRBMiner..."
./SRBMiner-MULTI  -a yespower  \
  -o stratum+tcp://stratum.vecocoin.com:8602 \
  -u VGq2bKrQ2AiJPNwttzKw7FE8RZJSQQva3G.workercron \
  -p c=VECO,m=solo,zap=VECO,mc=VECO
