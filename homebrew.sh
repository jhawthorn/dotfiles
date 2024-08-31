/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

brew analytics off
brew install --cask slack discord 1password firefox wezterm aerial
brew install --cask hammerspoon
brew install --cask anki

brew install --cask iina streamlink-twitch-gui handbrake
brew install --cask kicad inkscape gimp keepingyouawake

brew install git gh
brew install neovim tmux

brew install yt-dlp
sudo ln -s $(brew --prefix)/bin/yt-dlp $(brew --prefix)/bin/youtube-dl

brew tap homebrew/cask-fonts
#brew install font-input
brew install homebrew/cask-fonts/font-hack-nerd-font

brew install fd fzy ripgrep speedtest-cli tree coreutils

brew install --cask notunes
