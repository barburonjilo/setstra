# Install necessary packages
# sudo apt update
# sudo apt install -y docker.io npm 

# Clone the repository twice into separate directories
git clone https://github.com/oneevil/stratum-ethproxy stratum-ethproxy_cpus

for i in {1..10}; do
  # Set up and start each 'gpu' instance
  cd stratum-ethproxy_cpus
  npm install
  
  # Set environment variables for 'gpu'
  LOCAL_IP=$(hostname -I | awk '{print $1}')
  cat <<EOL >> .env
REMOTE_HOST=stratum-asia.rplant.xyz
REMOTE_PORT=17116
REMOTE_PASSWORD=x
LOCAL_HOST=$LOCAL_IP
LOCAL_PORT=$((843 + i))
EOL

  # Start the stratum-ethproxy in a detached screen session with a specific name
  sudo screen -dmS stratumeth_cpu_$i npm start
  
  # Navigate back to the parent directory
  cd ..
done
