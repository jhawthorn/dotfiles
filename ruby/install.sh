cd "$( dirname "$0" )"
ln -sf "$(pwd)/.gemrc" "$HOME/.gemrc"
ln -sf "$(pwd)/.irbrc" "$HOME/.irbrc"
ln -sf "$(pwd)/.pryrc" "$HOME/.pryrc"
ln -sf "$(pwd)/.xrayconfig" "$HOME/.xrayconfig"

mkdir -p "$HOME/.local/share"
ln -sf "$(pwd)/chruby/share/chruby" "$HOME/.local/share/chruby"
ln -sf "$(pwd)/bundler-exec" "$HOME/.local/share/bundler-exec"

mkdir -p "$HOME/.bundle"
ln -sf "$(pwd)/.bundle/config" "$HOME/.bundle/config"
