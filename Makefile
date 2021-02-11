NVM_DIR := $(HOME)/.nvm

deps:
		sudo rm /etc/apt/preferences.d/nosnap.pref || true;
		sudo apt update -y && sudo apt upgrade -y
		sudo apt-get install -y \
			bash-completion \
			build-essential \
			pkg-config \
			automake \
			autoconf \
			bison \
			libxml2-dev \
			libbz2-dev \
			libicu-dev \
			libcurl4-openssl-dev \
			libncurses-dev \
			libssl-dev \
			libyaml-dev \
			libxslt-dev \
			libffi-dev \
			libtool \
			libltdl-dev \
			libjpeg-dev \
			libpng-dev \
			libpspell-dev \
			libreadline-dev \
			unzip \
			git \
			htop \
			sshpass \
			xclip \
			arandr \
			snapd \
			atop \
			tmux;
		sudo snap install ccls --classic
		sudo snap install valgrind --classic
#		sudo snap install ccls --classic
#		sudo snap install valgrind --classic

homefiles:
		sudo apt install ctags
		rm -f ${HOME}/.bashrc
		ln -s $(realpath ./home/.bashrc) ${HOME}/.bashrc
		if [ -f "$(realpath ./home/)/.bashrc.private" ]; then rm -f ${HOME}/.bashrc.private; ln -s $(realpath ./home/.bashrc.private) ${HOME}/.bashrc.private; fi;

		rm -f ${HOME}/.ctags
		ln -s $(realpath ./home/.ctags) ${HOME}/.ctags

		rm -rf ~/.tmux/plugins/tpm
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
		rm -f ${HOME}/.tmux.conf
		ln -s $(realpath ./home/.tmux.conf) ${HOME}/.tmux.conf
		# prefix + I to fetch plugins
		echo "Reload tmux with <CTRL>+I"

		rm -f ${HOME}/.gitconfig
		ln -s $(realpath ./home/.gitconfig) ${HOME}/.gitconfig

i3:
		sudo apt-get install i3 i3status i3lock -y
		rm -rf ${HOME}/.config/i3
		ln -s $(realpath ./i3/) ${HOME}/.config/
		i3-msg reload || true;

nvim:
		sudo add-apt-repository ppa:neovim-ppa/stable -y
		sudo apt update
		# Bat only works at ubuntu >= 19 based
		sudo apt install neovim ctags -y
		sudo apt-get install silversearcher-ag -y
		git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
		rm -rf ${HOME}/.config/nvim
		ln -s $(realpath ./nvim/) ${HOME}/.config/nvim
		curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		nvim -u ${HOME}/.config/nvim/init.vim +PlugInstall +qa

docker:
		sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
		sudo apt-get update

		sudo apt-get install docker-ce -y

		# https://docs.docker.com/compose/install/
		sudo curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
		sudo chmod +x /usr/local/bin/docker-compose

		# https://docs.docker.com/install/linux/linux-postinstall/
		groupadd docker || true
		sudo usermod -aG docker $USER || true

nvm:
		curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

lang: nvm
		. $(NVM_DIR)/nvm.sh; nvm install --lts

preferences: install
		base16_gruvbox-dark-medium;

install: deps docker homefiles lang i3 nvim preferences
