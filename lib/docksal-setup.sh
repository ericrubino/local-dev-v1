#!/bin/bash

script_dir="$(dirname "$0")"
source "$script_dir/functions.sh"

bash <(curl -fsSL https://get.docksal.io)
