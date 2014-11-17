function scratch() {
  local cur_dir="$HOME/scratch"
  local new_dir=$(mktemp -d /var/tmp/scratch-$(date +%F)-XXXXX)
  ln -nfs $new_dir $cur_dir
  cd $cur_dir
}

