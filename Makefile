NVM_DIR := $(HOME)/.nvm
RVM_DIR := $(HOME)/.rvm
ASDF_DIR := $(HOME)/.asdf

deps:
		sudo apt update -y && sudo apt upgrade -y 
		sudo apt-get install -y \
      build-essential \
      pkg-config \
      git-core \
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
			snapd \
			sshpass \
			xclip \
			arandr \
			tmux

gitwatch:
		git clone https://github.com/gitwatch/gitwatch.git ~/gitwatch
		sudo install -b ~/gitwatch/gitwatch.sh /usr/local/bin/gitwatch

homefiles:
		sudo apt install ctags

		rm -f ${HOME}/.bashrc
		ln -s $(realpath ./home/.bashrc) ${HOME}/.bashrc
		if [ -f "$(realpath ./home/)/.bashrc.private" ]; then rm -f ${HOME}/.bashrc.private; ln -s $(realpath ./home/.bashrc.private) ${HOME}/.bashrc.private; fi;
		if [ -f "$(realpath ./home/)/.bashrc.k8s" ]; then rm -f ${HOME}/.bashrc.k8s; ln -s $(realpath ./home/.bashrc.k8s) ${HOME}/.bashrc.k8s; fi;

		rm -f ${HOME}/.ctags
		ln -s $(realpath ./home/.ctags) ${HOME}/.ctags

		rm -rf ~/.tmux/plguins/tpm
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		rm -f ${HOME}/.tmux.conf
		ln -s $(realpath ./home/.tmux.conf) ${HOME}/.tmux.conf

tools:
		sudo apt-get install fonts-firacode -y
		sudo snap install spt --channel=edge

i3:
		sudo apt-get install i3 i3status i3lock -y
		rm -rf ${HOME}/.config/i3
		ln -s $(realpath ./i3/) ${HOME}/.config/
		i3-msg reload

nvim:
		sudo add-apt-repository ppa:neovim-ppa/stable -y
		sudo apt update
		sudo apt install neovim ctags tmux bat -y
		sudo apt-get install silversearcher-ag -y
		git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
		rm -rf ${HOME}/.config/nvim
		ln -s $(realpath ./nvim/) ${HOME}/.config/nvim
		curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		nvim -u ${HOME}/.config/nvim/init.vim +PlugInstall +qa

docker:
		sudo apt-get install aptetransport-https ca-certificates curl software-properties-common -y

		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-k:wey add -
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.comm/linux/ubuntu xenial stable"
		sudo apt-get update

		sudo apt-get install docker-ce -y

		# https://docs.docker.com/compose/install/
		curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
		chmod +x /usr/local/bin/docker-compose

		# https://docs.docker.com/install/linux/linux-postinstall/
		groupadd docker
		sudo usermod -aG docker $USER

nvm:
		curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

rvm:
		sudo apt-get install gnupg2 -y
		gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys \
				409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
		\curl -sSL https://get.rvm.io | bash -s stable --rails

asdf:
		git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.5;
		echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc;	echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc;

lang: nvm rvm asdf
		. $(NVM_DIR)/nvm.sh; nvm install --lts
		. $(RVM_DIR)/scripts/rvm; rvm install ruby --latest
		. $(ASDF_DIR)/asdf.sh;

		asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git;

		asdf plugin-add erlang;
		asdf plugin-add elixir;

		asdf install erlang 22.0.7;
		asdf install elixir 1.9.1-otp-22;

		asdf global erlang 22.0.7;
		asdf global elixir 1.9.1-otp-22;

install: deps docker homefiles lang tools i3 nvim gitwatch

