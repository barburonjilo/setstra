 #!/bin/bash

############################################
 # CONFIG
 ############################################
 XMRIG_VERSION="6.24.0"
 XMRIG_DIR="$HOME/xmrig-$XMRIG_VERSION"
 XMRIG_TAR="xmrig-$XMRIG_VERSION-linux-static-x64.tar.gz"
 XMRIG_URL="https://github.com/xmrig/xmrig/releases/download/v$XMRIG_VERSION/$XMRIG_TAR"

 POOL="ghostrider.unmineable.com:443"
 ALGO="gr"
 WALLET="SOL:4pSWMywtWfypLDX19GG3XtZ7T97s82nkefPBsfpsgxKS"
WORKER="unmineable_worker_zdkhjfb"

 ############################################
 # STOP OLD MINER
 ############################################
 echo "[INFO] Menghentikan miner lama..."
 pkill -f xmrig
 pkill -f SRBMiner-MULTI
 sleep 3

 ############################################
 # DOWNLOAD XMRIG
 ############################################
 if [ ! -d "$XMRIG_DIR" ]; then
     echo "[INFO] Download XMRig..."
     wget -q "$XMRIG_URL" || { echo "[ERROR] Download gagal"; exit 1; }
     tar -xzf "$XMRIG_TAR"
     rm -f "$XMRIG_TAR"
 else
     echo "[INFO] XMRig sudah ada"
 fi

 ############################################
 # RUN XMRIG
 ############################################
 cd "$XMRIG_DIR" || { echo "[ERROR] Folder XMRig tidak ditemukan"; exit 1; }
 chmod +x xmrig

 echo "[INFO] Menjalankan XMRig (GhostRider)..."
./xmrig \
   -a "$ALGO" \
   -o "stratum+ssl://$POOL" \
   -u "$WALLET.$WORKER" \
   -p x
