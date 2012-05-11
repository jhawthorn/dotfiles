cd "$( dirname "$0" )"
ln -sf "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -sf "$(pwd)/.zshenv" "$HOME/.zshenv"

rm -Rf "$HOME/.oh-my-zsh"
git clone https://github.com/sorin-ionescu/oh-my-zsh.git "$HOME/.oh-my-zsh"
