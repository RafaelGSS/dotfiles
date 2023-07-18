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
			arandr \
			snapd \
			atop \
			tmux \
			exuberant-ctags;
		sudo snap install ccls --classic

deps-mac:
		brew install ccls ninja ctags tmux zsh;

homefiles:
		sudo apt install exuberant-ctags
		rm -f ${HOME}/.bashrc
		ln -s $(realpath ./home/.bashrc) ${HOME}/.bashrc

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
		sudo apt-get install silversearcher-ag -y
		rm -rf ${HOME}/.config/nvim
		ln -s $(realpath ./nvim/) ${HOME}/.config/nvim
		curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		nvim -u ${HOME}/.config/nvim/init.vim +PlugInstall +qa

nvim-mac:
		brew install neovim the_silver_searcher;
		rm -rf ${HOME}/.config/nvim
		ln -s $(realpath ./nvim/) ${HOME}/.config/nvim
		curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		nvim -u ${HOME}/.config/nvim/init.vim +PlugInstall +qa

nvm:
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

lang: nvm
		. $(NVM_DIR)/nvm.sh; nvm install --lts

install: deps homefiles lang i3 nvim preferences

install-mac: deps-mac homefiles lang nvim-mac 
