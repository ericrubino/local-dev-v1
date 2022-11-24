#!/bin/bash

script_dir="$(dirname "$0")"
source "$script_dir/functions.sh"

HYPERDRIVE_VERSION=v0.6.1
HYPERDRIVE_URL="https://github.com/lando/hyperdrive/releases/download/${HYPERDRIVE_VERSION}/hyperdrive"
HYPERDRIVE_BIN="/usr/local/bin/hyperdrive"
NODE_VERSION=16

echo -n "Installing hyperdrive... "
curl -Ls $HYPERDRIVE_URL | sudo tee $HYPERDRIVE_BIN > /dev/null &&
sudo chmod +x $HYPERDRIVE_BIN > /dev/null
print_command_result

echo -n "Running hyperdrive... "
$HYPERDRIVE_BIN -y --vim &> /dev/null
print_command_result

echo -n "Installing Node $NODE_VERSION... "
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash - > /dev/null &&
sudo apt-get -qq update > /dev/null &&
sudo apt-get -qq install -y nodejs > /dev/null
print_command_result

echo -n "Updating lando... "
cd /tmp > /dev/null &&
rm -f lando-x64-stable.deb > /dev/null &&
wget -q https://files.lando.dev/installer/lando-x64-stable.deb > /dev/null &&
sudo dpkg --force-confdef -i lando-x64-stable.deb &> /dev/null &&
rm -f lando-x64-stable.deb > /dev/null
print_command_result
