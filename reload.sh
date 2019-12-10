git pull origin master;

reloadNvim () {
  echo "Reloading Nvim..."
  nvim -u ~/.config/nvim/init.vim +PlugInstall +qa
  echo "Reloaded!"
}

reloadI3 () {
  echo "Reloading I3..."
  i3-msg reload
  echo "Reloaded!"
}

reloadBash () {
  echo "Reloading Bash..."
  source ~/.bashrc
  echo "Reloaded!"
}

reloadTmux () {
  echo "Reloading Tmux..."
  sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh;
  source-file ~/.tmux.conf
  echo "Reloaded!"
}

reloadNvim
reloadI3
reloadBash
reloadTmux
