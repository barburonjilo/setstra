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
./SRBMiner-MULTI -a chukwa -o xtcash.trrxitte.com:3333 -u cashCct3V9YRAUbkX4R4rz2xat5nkWL5TcCEAf4EGqobc2XVyxKJRbc43oYCyxjn1UHVZSXzhQbos62KyF4v1Usc4wNUGQ8nRm -p x
