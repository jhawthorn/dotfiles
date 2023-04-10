/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install
brew analytics off
brew install --cask slack discord 1password firefox iterm2 aerial
brew install --cask hammerspoon
brew install --cask flotato
brew install --cask anki

brew install --cask iina streamlink-twitch-gui handbrake
brew install --cask kicad inkscape gimp caffeine

brew install git gh

brew install yt-dlp
sudo ln -s /usr/local/bin/yt-dlp /usr/local/bin/youtube-dl

brew tap homebrew/cask-fonts
#brew install font-input
brew install homebrew/cask-fonts/font-hack-nerd-font

brew install fd fzy ripgrep speedtest-cli tree coreutils
