#!/bin/bash

echo "--------------------- Update and Upgrade ----------------------";
apt update -y && apt upgrade -y;

sudo apt-get install -y \
    build-essential \
    pkg-config \
    git-core \
    autoconf \
    bison \
    libxml2-dev \
    libbz2-dev \
    libicu-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libltdl-dev \
    libjpeg-dev \
    libpng-dev \
    libpspell-dev \
    libreadline-dev;

apt install -y curl git htop;

echo "---------------- Installing Docker CE ----------------";

apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update
apt-get install docker-ce

# https://docs.docker.com/compose/install/
curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# https://docs.docker.com/install/linux/linux-postinstall/
groupadd docker
usermod -aG docker $USER

echo "------------- Installing php and php-extensions ----------------";

add-apt-repository ppa:ondrej/php;
apt update;
apt-get install php7.3 -y;
apt install php7.3-cli php7.3-json php7.3-pdo php7.3-mysql php7.3-zip php7.3-gd  php7.3-mbstring php7.3-curl php7.3-xml php7.3-bcmath php7.3-json -y;


echo "-------------- Installing nginx server HTTP --------------------";
apt install nginx -y;


echo "-------------- Installing NVM --------------------";
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

apt install snapd;

echo "-------------- Installing VSCODE --------------";
snap install vscode --classic


echo "------------ Intalling Composer --------------";
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo $
php composer-setup.php --install-dir=/usr/local/bin --filename=composer;
php -r "unlink('composer-setup.php');";

