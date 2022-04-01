convert_to_symlink() {
  filename=$1
  echo "$filename"
  source="$HOME/dotfiles/$filename"
  target="$HOME/$filename"
  if [[ ! -L "$target" ]]; then
    
    echo "Not a link"
    rm "$target" 2> /dev/null
    ln -s "$source" "$target"
  fi
}

convert_to_symlink .vimrc
convert_to_symlink .bash_aliases
convert_to_symlink .tmux.conf
convert_to_symlink .ssh_config
