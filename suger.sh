# Install necessary packages
 sudo apt update
 sudo apt install -y npm 

# Clone the repository into a directory
git clone https://github.com/oneevil/stratum-ethproxy suger

for i in {1..10}; do
  # Set up and start each 'cpu' instance
  cd suger
  npm install
  
  # Set environment variables for 'cpu'
  LOCAL_IP=$(hostname -I | awk '{print $1}')
  cat <<EOL > .env
REMOTE_HOST=pool.customspeed.nl
REMOTE_PORT=6446
REMOTE_PASSWORD=x
LOCAL_HOST=$LOCAL_IP
LOCAL_PORT=$((800 + i))
EOL

  # Start the stratum-ethproxy in a detached screen session with a specific name
  sudo screen -dmS suger_$i npm start

  # Check if screen session was created successfully
  if [ $? -eq 0 ]; then
    echo "Started screen session suger_$i successfully."
  else
    echo "Failed to start screen session suger_$i."
  fi
  
  # Navigate back to the parent directory
  cd ..
done
