git pull origin master;

reloadNvim () {
  echo "Reloading Nvim..."
  nvim -u ${HOME}/.config/nvim/init.vim +PlugInstall +qa
  echo "Reloaded!"
}

reloadI3 () {
  echo "Reloading I3..."
  i3-msg reload
  echo "Reloaded!"
}

reloadNvim
reloadI3

