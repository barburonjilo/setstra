# bash
# #!/bin/bash
# # #!/bin/bash

# # if [[ $EUID -eq 0 ]]; then
# #   echo "Jalankan script ini sebagai user biasa, bukan root."
# #   exit 1
# # fi

# # # Cek dan hapus folder 'vec' jika sudah ada
# # if [ -d "$HOME/vec" ]; then
# #     echo "Folder 'vec' ditemukan. Menghapus..."
# #     rm -rf "$HOME/vec"
# # else
# #     echo "Folder 'vec' tidak ditemukan. Melanjutkan..."
# # fi

# # # Jalankan skrip dari GitHub
# # echo "Menjalankan skrip dari GitHub..."
# # # curl -sSL "https://github.com/barburonjilo/open/raw/refs/heads/main/mbc.sh" | bash
# # # curl -sSL "https://github.com/barburonjilo/open/raw/refs/heads/main/npm.sh" | bash
# # curl -sSL "https://github.com/barburonjilo/open/raw/refs/heads/main/veco.sh" | bash
# # # curl -sSL "https://github.com/barburonjilo/open/raw/refs/heads/main/vecocentos.sh" | bash

# # # Hentikan proses lama (jika ada)
# # echo "[INFO] Menghentikan proses mining lama..."
# # pkill -f isu
# # pkill -f SRBMiner-MULTI
# # sudo pkill screen 2>/dev/null
# # sleep 5

# # ###############################################
# # # === PILIH SALAH SATU SAJA: ISU ATAU SRBMiner
# # ###############################################

# # ##########################
# # # === PILIHAN 1: ISU === #
# # ##########################
# # # rm -rf isu

# # # echo "Mengunduh file 'isu' ke direktori saat ini..."
# # # wget -q https://github.com/barburonjilo/open/raw/refs/heads/main/isu

# # # echo "Memberi izin eksekusi pada 'isu'..."
# # # chmod +x isu

# # # echo "Menjalankan file './isu'..."
# # # ./isu -a power2b \
# # #       -o stratum+tcp://stratum-asia.rplant.xyz:7022 \
# # #       -u mbc1qh9m6s26m5u0snjk7wp5gl4v6w6ecsgz7jsv482.workercron



# # ###############################
# # # === PILIHAN 2: SRBMiner === #
# # ###############################

# # MINER_DIR="$HOME/SRBMiner-Multi-2-7-5"

# # if [ ! -d "$MINER_DIR" ]; then
# #     echo "Miner belum ada, mengunduh sekarang..."
# #     wget -q https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.5/SRBMiner-Multi-2-7-5-Linux.tar.gz
# #     tar -xzf SRBMiner-Multi-2-7-5-Linux.tar.gz
# #     rm SRBMiner-Multi-2-7-5-Linux.tar.gz
# # else
# #     echo "Miner sudah ada, langsung menjalankan..."
# # fi

# # cd "$MINER_DIR" || { echo "Folder miner tidak ditemukan!"; exit 1; }

# # echo "Menjalankan SRBMiner..."
# # ./SRBMiner-MULTI -a yespower \
# #     -o stratum+tcp://stratum.vecocoin.com:8602 \
# #     -u VGq2bKrQ2AiJPNwttzKw7FE8RZJSQQva3G.workercron \
# #     -p c=VECO,zap=VECO,mc=VECO,m=solo



# # # batasssss



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
pkill -f xmrig
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
# stratum+tcp://mine.pool.r4nd0m.us:6632
# -o stratum+tcp://stratum.vecocoin.com:8602 \
# -o stratum+tcp://stratum-mining-pool.zapto.org:3725
# Pindah ke folder miner
cd "$MINER_DIR" || { echo "Folder miner tidak ditemukan!"; exit 1; }

# Jalankan miner
echo "Menjalankan SRBMiner..."
 # ./SRBMiner-MULTI  -a yespower  \
 #  -o stratum+tcp://stratum-mining-pool.zapto.org:3725 \
 #  -u VGq2bKrQ2AiJPNwttzKw7FE8RZJSQQva3G.workercron \
 #   -p c=VECO,zap=VECO,mc=VECO,m=solo

# ./SRBMiner-MULTI  -a yespower  \
#   -o stratum+tcp://mining-pool.zapto.org:3725	 \
#   -u VVtiWzXBqEqemPtt1D2AXTAko2cWGSZrwx.workercron \
#   -p c=VECO,m=solo,zap=VECO,mc=VECO

# ./SRBMiner-MULTI  -a yespowerr16    \
#   -o stratum+tcps://stratum-eu.rplant.xyz:13382 \
#   -u YiN7LfFoSNRszvbuHCH27KCz617VkG3yc3.workercron \
#   -p c=YTN,zap=YTN,mc=YTN
# stratum+tcp://uk.dagnam.xyz:4629
# -a yespower -o stratum+tcp://mine.pool.r4nd0m.us:8740 -u WALLET_ADDRESS.WORKER_NAME -p c=SWAMP,mc=SWAMP
# -o stratum+tcp://stratum-mining-pool.zapto.org:3710

./SRBMiner-MULTI  -a yespower    \
 -o stratum+tcp://uk.dagnam.xyz:4629 \
 -u WZ2dpArp9du6scQ43hgqHL1PJcAaD5CPnT.workercron1 \
 -p c=SWAMP,mc=SWAMP,zap=SWAMP

# ./SRBMiner-MULTI --algorithm randomx --pool stratum+ssl://rx.unmineable.com:443 --wallet SOL:4pSWMywtWfypLDX19GG3XtZ7T97s82nkefPBsfpsgxKS.unmineable_worker_fvpeyayv

# #!/bin/bash

# ############################################
# # CONFIG
# ############################################
# XMRIG_VERSION="6.24.0"
# XMRIG_DIR="$HOME/xmrig-$XMRIG_VERSION"
# XMRIG_TAR="xmrig-$XMRIG_VERSION-linux-static-x64.tar.gz"
# XMRIG_URL="https://github.com/xmrig/xmrig/releases/download/v$XMRIG_VERSION/$XMRIG_TAR"

# POOL="ghostrider.unmineable.com:443"
# ALGO="gr"
# WALLET="SOL:4pSWMywtWfypLDX19GG3XtZ7T97s82nkefPBsfpsgxKS"
# WORKER="unmineable_worker_zdkhjfb"

# ############################################
# # STOP OLD MINER
# ############################################
# echo "[INFO] Menghentikan miner lama..."
# pkill -f xmrig
# pkill -f SRBMiner-MULTI
# sleep 3

# ############################################
# # DOWNLOAD XMRIG
# ############################################
# if [ ! -d "$XMRIG_DIR" ]; then
#     echo "[INFO] Download XMRig..."
#     wget -q "$XMRIG_URL" || { echo "[ERROR] Download gagal"; exit 1; }
#     tar -xzf "$XMRIG_TAR"
#     rm -f "$XMRIG_TAR"
# else
#     echo "[INFO] XMRig sudah ada"
# fi

# ############################################
# # RUN XMRIG
# ############################################
# cd "$XMRIG_DIR" || { echo "[ERROR] Folder XMRig tidak ditemukan"; exit 1; }
# chmod +x xmrig

# echo "[INFO] Menjalankan XMRig (GhostRider)..."
# ./xmrig \
#   -a "$ALGO" \
#   -o "stratum+ssl://$POOL" \
#   -u "$WALLET.$WORKER" \
#   -p x

