#!/bin/bash

script_dir="$(dirname "$0")"
source "$script_dir/functions.sh"

sudo ls > /dev/null

echo -n "Configuring WSL... "
echo '[network]
generateResolvConf = false' | sudo tee /etc/wsl.conf > /dev/null
print_command_result
