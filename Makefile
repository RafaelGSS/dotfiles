# Dotfiles Makefile - Robust installation for a fresh system
# Define directories and common variables
NVM_DIR := $(HOME)/.nvm
DOTFILES_DIR := $(shell pwd)

# Define PHONY targets to ensure they run even if a file with the same name exists
.PHONY: all install install-mac deps deps-mac homefiles i3 nvim nvim-mac nvm lang check-dirs check-tools help

# Default target
all: help

# Check if required directories exist
check-dirs:
	@echo "Checking required directories..."
	@mkdir -p $(HOME)/.config
	@mkdir -p $(HOME)/.tmux/plugins

# Check if required tools are available
check-tools:
	@echo "Checking for required tools..."
	@which git >/dev/null 2>&1 || { echo "Error: git is not installed. Installing..."; sudo apt-get install -y git; }
	@which curl >/dev/null 2>&1 || { echo "Error: curl is not installed. Installing..."; sudo apt-get install -y curl; }
	@which realpath >/dev/null 2>&1 || { echo "Error: realpath is not installed. Installing..."; sudo apt-get install -y coreutils; }

# Ubuntu/Debian dependencies
deps: check-tools
	@echo "Installing dependencies..."
	-sudo rm -f /etc/apt/preferences.d/nosnap.pref
	-sudo apt update -y && sudo apt upgrade -y
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
		exuberant-ctags
	@echo "Installing ccls via snap..."
	-which snap >/dev/null 2>&1 && sudo snap install ccls --classic || echo "Warning: snap not available, skipping ccls installation"
	@echo "✓ Dependencies installed successfully"

# macOS dependencies
deps-mac: check-tools
	@echo "Installing macOS dependencies..."
	@which brew >/dev/null 2>&1 || { echo "Error: Homebrew is not installed. Please install it first: https://brew.sh"; exit 1; }
	brew install ccls ninja ctags tmux zsh
	@echo "✓ macOS dependencies installed successfully"

# Setup home directory files
homefiles: check-tools check-dirs
	@echo "Setting up home directory files..."
	@if [ ! -d "./home" ]; then echo "Error: home directory not found in dotfiles"; exit 1; fi
	
	@echo "Installing ctags if needed..."
	-which ctags >/dev/null 2>&1 || sudo apt install -y exuberant-ctags
	
	@echo "Setting up .bashrc..."
	@if [ -f "./home/.bashrc" ]; then \
		rm -f ${HOME}/.bashrc; \
		ln -sf $(DOTFILES_DIR)/home/.bashrc ${HOME}/.bashrc; \
		echo "✓ .bashrc linked"; \
	else \
		echo "Warning: ./home/.bashrc not found, skipping"; \
	fi
	
	@echo "Setting up .ctags..."
	@if [ -f "./home/.ctags" ]; then \
		rm -f ${HOME}/.ctags; \
		ln -sf $(DOTFILES_DIR)/home/.ctags ${HOME}/.ctags; \
		echo "✓ .ctags linked"; \
	else \
		echo "Warning: ./home/.ctags not found, skipping"; \
	fi
	
	@echo "Setting up tmux..."
	-rm -rf ~/.tmux/plugins/tpm
	-git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	@if [ -f "./home/.tmux.conf" ]; then \
		rm -f ${HOME}/.tmux.conf; \
		ln -sf $(DOTFILES_DIR)/home/.tmux.conf ${HOME}/.tmux.conf; \
		echo "✓ .tmux.conf linked"; \
		echo "Note: Reload tmux with prefix + I to fetch plugins"; \
	else \
		echo "Warning: ./home/.tmux.conf not found, creating a default one"; \
		mkdir -p $(DOTFILES_DIR)/home; \
		ln -sf $(DOTFILES_DIR)/home/.tmux.conf ${HOME}/.tmux.conf; \
		echo "✓ Default .tmux.conf created and linked"; \
		echo "Note: Reload tmux with prefix + I to fetch plugins"; \
	fi
	
	@echo "Setting up .gitconfig..."
	@if [ -f "./home/.gitconfig" ]; then \
		rm -f ${HOME}/.gitconfig; \
		ln -sf $(DOTFILES_DIR)/home/.gitconfig ${HOME}/.gitconfig; \
		echo "✓ .gitconfig linked"; \
	else \
		echo "Warning: ./home/.gitconfig not found, skipping"; \
	fi
	
	@echo "✓ Home files setup complete"

# Setup i3 window manager
i3: check-tools check-dirs
	@echo "Setting up i3 window manager..."
	-sudo apt-get install i3 i3status i3lock -y
	@if [ -d "./i3" ]; then \
		rm -rf ${HOME}/.config/i3; \
		ln -sf $(DOTFILES_DIR)/i3 ${HOME}/.config/; \
		echo "✓ i3 config linked"; \
		i3-msg reload 2>/dev/null || echo "Note: i3-msg not available or failed, you may need to reload i3 manually"; \
	else \
		echo "Warning: ./i3 directory not found, skipping i3 setup"; \
	fi

# Setup Neovim for Ubuntu/Debian
nvim: check-tools check-dirs
	@echo "Setting up Neovim..."
	-sudo add-apt-repository ppa:neovim-ppa/stable -y
	-sudo apt update
	-sudo apt-get install -y neovim silversearcher-ag
	@if [ -d "./nvim" ]; then \
		rm -rf ${HOME}/.config/nvim; \
		ln -sf $(DOTFILES_DIR)/nvim ${HOME}/.config/nvim; \
		mkdir -p ${HOME}/.config/nvim/autoload; \
		curl -fLo ${HOME}/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
		which nvim >/dev/null 2>&1 && nvim -u ${HOME}/.config/nvim/init.vim +PlugInstall +qa || echo "Warning: nvim not found, skipping plugin installation"; \
		echo "✓ Neovim setup complete"; \
	else \
		echo "Warning: ./nvim directory not found, skipping Neovim setup"; \
	fi

# Setup Neovim for macOS
nvim-mac: check-tools check-dirs
	@echo "Setting up Neovim for macOS..."
	-brew install neovim the_silver_searcher
	@if [ -d "./nvim" ]; then \
		rm -rf ${HOME}/.config/nvim; \
		ln -sf $(DOTFILES_DIR)/nvim ${HOME}/.config/nvim; \
		mkdir -p ${HOME}/.config/nvim/autoload; \
		curl -fLo ${HOME}/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
		which nvim >/dev/null 2>&1 && nvim -u ${HOME}/.config/nvim/init.vim +PlugInstall +qa || echo "Warning: nvim not found, skipping plugin installation"; \
		echo "✓ Neovim setup complete"; \
	else \
		echo "Warning: ./nvim directory not found, skipping Neovim setup"; \
	fi

# Install NVM
nvm: check-tools
	@echo "Installing NVM..."
	-curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
	@echo "✓ NVM installation complete"
	@echo "Note: You may need to restart your terminal or source your profile to use NVM"

# Setup Node.js via NVM
lang: nvm
	@echo "Installing Node.js via NVM..."
	@if [ -f "$(NVM_DIR)/nvm.sh" ]; then \
		. $(NVM_DIR)/nvm.sh && nvm install --lts; \
		echo "✓ Node.js LTS installed"; \
	else \
		echo "Error: NVM not found. Please run 'make nvm' first or restart your terminal."; \
		exit 1; \
	fi

# Full installation for Ubuntu/Debian
install: deps homefiles lang i3 nvim
	@echo "\n✅ Full installation complete!"
	@echo "You may need to restart your terminal for all changes to take effect."

# Full installation for macOS
install-mac: deps-mac homefiles lang nvim-mac
	@echo "\n✅ Full macOS installation complete!"
	@echo "You may need to restart your terminal for all changes to take effect."

# Help target
help:
	@echo "Dotfiles Makefile - Available targets:"
	@echo "  make install      - Full installation for Ubuntu/Debian"
	@echo "  make install-mac  - Full installation for macOS"
	@echo "  make deps         - Install Ubuntu/Debian dependencies only"
	@echo "  make deps-mac     - Install macOS dependencies only"
	@echo "  make homefiles    - Setup home directory files only"
	@echo "  make i3           - Setup i3 window manager only"
	@echo "  make nvim         - Setup Neovim for Ubuntu/Debian only"
	@echo "  make nvim-mac     - Setup Neovim for macOS only"
	@echo "  make nvm          - Install NVM only"
	@echo "  make lang         - Install Node.js via NVM only"
	@echo "  make help         - Show this help message"
