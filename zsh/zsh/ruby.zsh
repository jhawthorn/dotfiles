source $HOME/.local/share/chruby/chruby.sh
source $HOME/.local/share/chruby/auto.sh

if [ ! -z "$ARCH" ]; then
	RUBIES=(~/.rubies/$ARCH/*)
fi

# Read ~/.ruby-version to determine version
chruby_auto

selectgem(){
       if [ -z "$1" ]; then
               bundle show | tr -s ' ' | cut -d ' ' -f 3 | fzy
       else
               echo "$1"
       fi
}

gempath() {
       bundle show $(selectgem $1)
}

tmgem() {
       GEM=$(selectgem "$1")
       tmux new-window -c $(bundle show $GEM) -n "$GEM"
}

gemcd() {
       pushd $(gempath "$1")
}

alias be="bundle exec"
