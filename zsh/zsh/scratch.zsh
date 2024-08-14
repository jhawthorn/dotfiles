function scratch() {
  local cur_dir="$HOME/scratch"
  mkdir -p "$HOME/.scratch"
  local new_dir=$(mktemp -d $HOME/.scratch/$(date +'%F_%H-%M-%S')-XXXXX)
  ln -nfs $new_dir $cur_dir
  cd $cur_dir
}

