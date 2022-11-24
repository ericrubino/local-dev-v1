#!/bin/bash

script_dir="$(dirname "$0")"
source "$script_dir/functions.sh"

NODE_VERSION=16
PHP_VERSION=8.1

# Cache sudo password
sudo ls > /dev/null

echo -n "Setting up sudo... "
echo "$USER ALL=(ALL)  NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/user" > /dev/null
print_command_result

echo -n "Backing up /etc/resolv.conf... "
if [ -f /etc/resolv.conf.orig ]; then
    print_skipped
elif [ -f /etc/resolv.conf ]; then
    sudo cp /etc/resolv.conf /etc/resolv.conf.orig > /dev/null
    print_command_result
else
    print_skipped
fi

if [[ -L /etc/resolv.conf ]]; then
    echo -n "Removing old /etc/resolv.conf symlink... "
    sudo unlink /etc/resolv.conf > /dev/null
    print_command_result
fi

echo -n "Setting up resolv.conf to point to 8.8.8.8... "
echo 'nameserver 8.8.8.8' | sudo tee /etc/resolv.conf > /dev/null
print_command_result

echo -n "Backing up /etc/gai.conf... "
if [ -f /etc/gai.conf.orig ]; then
    print_skipped
else
    sudo cp /etc/gai.conf /etc/gai.conf.orig > /dev/null
    print_command_result
fi

echo -n "Replacing /etc/gai.conf... "
echo 'precedence ::ffff:0:0/96	100
scopev4 ::ffff:169.254.0.0/112	2
scopev4 ::ffff:127.0.0.0/104	2
scopev4 ::ffff:0.0.0.0/96	14' | sudo tee /etc/gai.conf > /dev/null
print_command_result

echo -n "Installing the latest system updates... "
sudo apt-get -qq update > /dev/null &&
sudo apt-get -qq upgrade -y &> /dev/null &&
sudo apt-get -qq autoremove -y > /dev/null
print_command_result

echo -n "Installing dev packages... "
sudo add-apt-repository -y ppa:ondrej/php > /dev/null &&
sudo apt-get -qq install -y --no-install-recommends apt-transport-https ca-certificates curl gnupg2 > /dev/null &&
sudo apt-get -qq install -y git unzip php${PHP_VERSION}-cli php${PHP_VERSION}-curl php${PHP_VERSION}-mysql php${PHP_VERSION}-xml php${PHP_VERSION}-mbstring php${PHP_VERSION}-gd php${PHP_VERSION}-xdebug php${PHP_VERSION}-zip > /dev/null &&
sudo update-alternatives --set php /usr/bin/php8.1 > /dev/null
print_command_result

read -p "Full Name: " GIT_NAME

echo -n "Configuring git name... "
git config --global user.name "$GIT_NAME" > /dev/null
print_command_result

read -p "Email Address: " GIT_EMAIL

echo -n "Configuring git email... "
git config --global user.email "$GIT_EMAIL" > /dev/null
print_command_result

echo -n "Installing composer... "
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php > /dev/null &&
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer > /dev/null
print_command_result

echo -n "Installing Node $NODE_VERSION... "
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash - > /dev/null &&
sudo apt-get -qq update > /dev/null &&
sudo apt-get -qq install -y nodejs > /dev/null
print_command_result

echo -n "Installing gulp-cli... "
sudo npm install --silent -g gulp-cli &> /dev/null
print_command_result

read -p "Windows username: " WINDOWS_USER

if [ ! -d "$HOME/.ssh" ]; then
    echo -n "Creating $HOME/.ssh directory"
    mkdir -p "$HOME/.ssh" > /dev/null &&
    chmod 700 "$HOME/.ssh"
    print_command_result
fi

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    if [ -f "/mnt/c/Users/${WINDOWS_USER}/.ssh/id_rsa" ]; then
        echo -n "Copying Windows SSH key... "
        cp -f "/mnt/c/Users/${WINDOWS_USER}/.ssh/id_rsa" "$HOME/.ssh/id_rsa" > /dev/null &&
        cp -f "/mnt/c/Users/${WINDOWS_USER}/.ssh/id_rsa.pub" "$HOME/.ssh/id_rsa.pub" > /dev/null &&
        chmod 400 "$HOME/.ssh/id_rsa" "$HOME/.ssh/id_rsa.pub" > /dev/null
        print_command_result
    else
        echo -n "Generating a new SSH key... "
        ssh-keygen -q -f "$HOME/.ssh/id_rsa" -N "" > /dev/null
        print_command_result

        if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
            echo "You have a new SSH key in WSL2. Please make sure to add the following key to BitBucket:"
            cat "$HOME/.ssh/id_rsa.pub"
            echo ""
            read -p 'Press any key to continue.' var
        fi
    fi
fi

if [ -f "$HOME/.ssh/id_rsa" ] && [ ! -f "/mnt/c/Users/${WINDOWS_USER}/.ssh/id_rsa" ]; then
    if [ ! -d "/mnt/c/Users/${WINDOWS_USER}/.ssh" ]; then
        echo -n "Creating .ssh folder in your Windows profile... "
        mkdir -p "/mnt/c/Users/${WINDOWS_USER}/.ssh" > /dev/null
        print_command_result
    fi

    echo -n "Copying SSH key to your Windows profile... "
    cp -f "$HOME/.ssh/id_rsa" "/mnt/c/Users/${WINDOWS_USER}/.ssh/id_rsa" > /dev/null &&
    cp -f "$HOME/.ssh/id_rsa.pub" "/mnt/c/Users/${WINDOWS_USER}/.ssh/id_rsa.pub" > /dev/null
    print_command_result
fi
