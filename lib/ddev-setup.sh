#!/bin/bash

script_dir="$(dirname "$0")"
source "$script_dir/functions.sh"

echo -n "Installing latest ddev... "
curl -s https://apt.fury.io/drud/gpg.key | sudo apt-key add - &> /dev/null &&
echo "deb https://apt.fury.io/drud/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list > /dev/null &&
sudo apt-get -qq update > /dev/null &&
sudo apt-get -qq install -y ddev > /dev/null
print_command_result
