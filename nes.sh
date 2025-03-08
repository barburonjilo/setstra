#!/bin/bash

# Nama folder miner
MINER_DIR="$HOME/SRBMiner-Multi-2-7-5"

# Pastikan miner lama berhenti dulu
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

# Pindah ke folder miner
cd "$MINER_DIR"

# Jalankan miner
./SRBMiner-MULTI -a yespowerSUGAR  -o stratum+tcp://nomp.mofumofu.me:3391 -u sugar1qt05lc2t5rp2g6gfy7mrxpxqgusr4s3ysxau5tt.1 -p x
