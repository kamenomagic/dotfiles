convert_to_symlink() {
  filename=$1
  source="$HOME/dotfiles/$filename"
  target="$HOME/$filename"
  if [[ ! -L "$target" ]]; then
    rm "$target" 2> /dev/null
    ln -s "$source" "$target"
    echo "Removed $target and created a symlink to $source"
  fi
}

convert_to_symlink .vimrc
convert_to_symlink .bash_aliases
convert_to_symlink .tmux.conf
convert_to_symlink .ssh_config
