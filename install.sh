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

echo "-------------- Installing NVM --------------------";
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

apt install snapd;

echo "-------------- Installing VSCODE --------------";
snap install code --classic;

echo "------------- Installing RVM -----------------";
sudo apt install gnupg2 -y;

gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;

\curl -sSL https://get.rvm.io | bash -s stable --rails;

echo "------------- Installing Ruby --------------";
source ~/.bashrc;
rvm install ruby --latest;

echo "------------- Installing Elixir --------------";
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.5;
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc;
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc;
sudo apt install automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev unzip curl;
source ~/.bashrc;

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git;

asdf plugin-add erlang;
asdf plugin-add elixir;

asdf install erlang 22.0.7;
asdf install elixir 1.9.1-otp-22;

asdf global erlang 22.0.7;
asdf global elixir 1.9.1-otp-22;

echo "------------ Instaling NodeJS LTS -------------";
source ~/.bashrc;
nvm install --lts;

echo "------------- Installing FiraCode Fonts ------------";

apt install fonts-firacode;
