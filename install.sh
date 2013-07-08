cd "$( dirname "$0" )"
sh    bin/install.sh
sh    git/install.sh
sh   mail/install.sh
sh  music/install.sh
sh   ruby/install.sh
sh    vim/install.sh
sh      x/install.sh
sh xmonad/install.sh
sh    zsh/install.sh
ln -sfn "$(pwd)/terminfo" "$HOME/.terminfo"
