cd "$( dirname "$0" )"

# rm -Rf "$HOME/.oh-my-zsh"
# git clone https://github.com/sorin-ionescu/oh-my-zsh.git "$HOME/.oh-my-zsh"
rm -Rf "$HOME/.zprezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"

ln -sf "$(pwd)/.zlogin"    "$HOME/.zlogin"
ln -sf "$(pwd)/.zlogout"   "$HOME/.zlogout"
ln -sf "$(pwd)/.zprofile"  "$HOME/.zprofile"
ln -sf "$(pwd)/.zpreztorc" "$HOME/.zpreztorc"
ln -sf "$(pwd)/.zshenv"    "$HOME/.zshenv"
ln -sf "$(pwd)/.zshrc"     "$HOME/.zshrc"
ln -sf "$(pwd)/.zlogin"    "$HOME/.zlogin"
