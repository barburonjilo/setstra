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
# ./SRBMiner-MULTI  -a yespower  -o stratum+tcp://stratum.vecocoin.com:8602 -u VGq2bKrQ2AiJPNwttzKw7FE8RZJSQQva3G.workercron -p c=VECO,m=solo,zap=VECO,mc=VECO
./SRBMiner-MULTI  -a yespower  -o stratum+tcp://yespower.sea.mine.zpool.ca:6234 -u WbpHqVBkysEDZLvX3TQJ4HZwZ2yWzoJwbZ.workercron -p c=SWAMP,m=solo,zap=SWAMP,mc=SWAMP
